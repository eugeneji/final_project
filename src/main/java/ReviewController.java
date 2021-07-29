package more.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import java.util.*;
import more.review.model.*;
import more.user.model.*;


@Controller
@EnableWebMvc
public class ReviewController {

	@Autowired
	private ReviewDAO reviewDao;
	
	@RequestMapping("reviewContent.do")
	public ModelAndView reviewList(HttpSession session) {
		
		int user_idx = ((UserDTO)session.getAttribute("s_user")).getUser_idx();
		ModelAndView mav = new ModelAndView();
		mav.addObject("reviewList", reviewDao.sitterReview(user_idx)) ;
		mav.setViewName("petsitter/review/sitterReview");
		return mav;
	}
	
	@RequestMapping("reviewList.do")
	public ModelAndView reviewList(@RequestParam(value = "cp", defaultValue = "1")int cp) {
		
		ModelAndView mav = new ModelAndView();
		int listN=6;
		mav.addObject("reviewList", reviewDao.reviewList(cp,listN)) ;
		mav.setViewName("petsitter/review/list");
		
		System.out.println();
		return mav;
	}
	
	@RequestMapping(value = "reviewWrite.do", method = RequestMethod.GET)
	public String reviewWriteForm(int book_idx) {
		
		return "petsitter/review/write";
	}
	
	@RequestMapping(value = "reviewWrite.do", method = RequestMethod.POST)
	@ResponseBody
	public Map reviewWrite(ReviewDTO dto, HttpServletRequest req) {
		System.out.println(dto);
		StringBuffer sb = new StringBuffer();
		
		int idx=0;
		for(int i=0;i<dto.getUploads().length;i++) {
			
			if(!dto.getUploads()[i].isEmpty()) {
				copyInto(dto.getBook_idx(), "/review/", "/"+idx+".png", dto.getUploads()[idx++], req);
				sb.append(i);
			}
		}
		
		dto.setReview_img(sb.toString());
		reviewDao.insertReview(dto);
		
		Map<String,String> map = new HashMap<String, String>();
		String alarm = "<a href='reviewContent.do?review_idx="+dto.getReview_idx()+"'>리뷰가 달렸어요</a>";
		map.put("message", alarm);
		map.put("type","alarm");
		map.put("sitter_idx",""+dto.getSitter_idx());
		
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
