package more.controller;

import java.io.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import more.sitter.model.*;
import more.pet.model.PetDAO;
import more.review.model.*;
import java.util.*;
import more.pet.model.PetDTO;
@Controller
@EnableWebMvc
public class sitterController {
	
	@Autowired
	private SitterDAO sitterDao;
	@Autowired
	private ReviewDAO reviewDAO;
	@Autowired
	private PetDAO petDao;
	
	@RequestMapping("sitterProfile.do")
	public ModelAndView sitterProfile(int user_idx) {
		
		List map = petDao.pet_list(user_idx);
		System.out.println(map.size());
		ModelAndView mav = new ModelAndView();
		mav.addObject("sitter",sitterDao.sitterProfile(user_idx));
		mav.addObject("reviewList", reviewDAO.sitterReview(user_idx));
		mav.addObject("petList", petDao.pet_list(user_idx));
		mav.setViewName("petsitter/sitter/profile");
		
		return mav;
	}
	
	@RequestMapping("insertProfile.do")
	public ModelAndView insertProfile(SitterDTO dto, HttpServletRequest req) {
		
		StringBuffer sb = new StringBuffer();
		
		int idx=0;
		for(int i=0;i<dto.getUploads().length;i++) {
			
			if(!dto.getUploads()[i].isEmpty()) {
				copyInto(dto.getUser_idx(), "/sitter/", "/background"+idx+".png", dto.getUploads()[idx++], req);
				sb.append(i);
			}
		}
		
		dto.setImg(sb.toString());
		sitterDao.insertProfile(dto);
		return sitterProfile(dto.getUser_idx());
	}
	
	@RequestMapping(value = "updateProfile.do", method = RequestMethod.GET)
	public ModelAndView updateProfileForm(int user_idx) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", sitterDao.selectProfile(user_idx));
		mav.setViewName("petsitter/sitter/insertProfile");
		
		return mav;
	}
	
	@RequestMapping(value = "updateProfile.do", method = RequestMethod.POST)
	public ModelAndView updateProfile(SitterDTO dto, HttpServletRequest req) {
		
		sitterDao.deleteProfile(dto.getUser_idx());
		
		return insertProfile(dto,req);
	}
	
	@RequestMapping("insertSitter.do")
	public ModelAndView insertSitter(SitterDTO dto) {
		
		sitterDao.insertSitter(dto);
		
		return adminSitterAcceptForm(1);
	}
	
	@RequestMapping("applyContent.do")
	public ModelAndView applyContent(int apply_idx) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", sitterDao.applyContent(apply_idx));
		mav.setViewName("admin/sitter/applyContent");
		
		return mav;
	}
	
	@RequestMapping("adminSitterAccept.do")
	public ModelAndView adminSitterAcceptForm(@RequestParam(value = "cp", defaultValue = "1")int cp) {
		
		int cnt = sitterDao.acceptTotalCnt();
		int list = 10;
		int pageN = 5;
		List arr = sitterDao.adminSitterAcceptAllList(cp, list);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", arr);
		mav.addObject("page", more.page.GuestPageModule.guestMakePage("adminSitterAccept.do", cnt, cp, list, pageN));
		
		mav.setViewName("admin/sitter/accept");
		return mav;
	}
	
	@RequestMapping("sitterMypage.do")
	public String sitterMypage(String user_idx) {
		
		if(sitterDao.isProfile(user_idx) == 0) 
			return "petsitter/sitter/insertProfile";
		
		return "petsitter/sitter/mypage";
	}
	
	@RequestMapping(value="sitterApply.do", method=RequestMethod.GET )
	public String sitterApplyForm() {
		
		return "petsitter/sitter/apply";
		
	}
	
	@RequestMapping(value="sitterApply.do", method=RequestMethod.POST )
	@ResponseBody
	public Map sitterApply(SitterDTO sdto, HttpServletRequest req) {
		
		copyInto(sdto.getUser_idx(), "/sitter/", "/license.png", sdto.getUpload(), req);
		sdto.setLicense("license");
		sitterDao.sitterApply(sdto);
		
		Map<String,String> map = new HashMap<String, String>();
		String alarm = "<a href='applyContent.do?apply_idx="+sdto.getApply_idx()+"'>시터 신청 도착</a>";
		map.put("message", alarm);
		map.put("type","alarm");
		
		return map;
	}
	
	private void copyInto(int user_idx, String path, String fileName, MultipartFile upload, HttpServletRequest req) {
		
		try {
			//원본
			byte bytes[] = upload.getBytes();
			File sitterPath = new File(req.getSession().getServletContext().getRealPath(path)+user_idx);
			if(!sitterPath.exists()) {
				sitterPath.mkdirs();
			}
			//빈종이
			File outFile = new File(req.getSession().getServletContext().getRealPath(path)+user_idx+fileName);
			FileOutputStream fos = new FileOutputStream(outFile);
			//복사
			fos.write(bytes);
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
