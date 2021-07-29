package more.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import more.pet.model.*;
import more.user.model.UserDTO;

@Controller
public class PetController {
	
	@Autowired
	private PetDAO dao;
	
	@RequestMapping("/pet_list.do")
	public ModelAndView pet_list(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		UserDTO dto = (UserDTO)session.getAttribute("s_user");
		
		if(dto==null) {
			mav.setViewName("redirect:login.do");
		}else {
			int user_idx = dto.getUser_idx();
			List<Map<String, String>> list = dao.pet_list(user_idx);
			mav.setViewName("pet/pet_list");
			mav.addObject("pet_list", list);
		}
		
		
		return mav;
	}
	
	
	@RequestMapping("/pet_info.do")
	public ModelAndView pet_info(String pet_idx) {
		ModelAndView mav = new ModelAndView();
		
		if(pet_idx==null || pet_idx=="") {
			mav.setViewName("redirect:pet_list.do");
		}else {
			PetDTO dto = dao.pet_info(pet_idx);
			mav.setViewName("pet/pet_info");
			mav.addObject("dto", dto);
		}
		return mav;
	}
	
	@RequestMapping("/pet_register.do")
	public ModelAndView pet_register(HttpServletRequest req) {
		
		String beforeURL = req.getHeader("REFERER");
		System.out.println(beforeURL);

		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pet/pet_register");
		mav.addObject("beforeURL", beforeURL);
		return mav;
	}
	
	@RequestMapping("/pet_register_com.do")
	public ModelAndView pet_register_com(MultipartFile blob, HttpServletRequest req, PetDTO dto, int user_idx) {
		
		int sequence = dao.pet_register(dto,user_idx);
		if(blob!=null) {
			copyInto(sequence,blob, req);
		}else {
			File def_img = new File(req.getSession().getServletContext().getRealPath("/pet/default.png"));
			
			File copy_path = new File(req.getSession().getServletContext().getRealPath("/pet/")+sequence);
			if(!copy_path.exists()) {
				copy_path.mkdirs();
			}
			File copy_img = new File(req.getSession().getServletContext().getRealPath("/pet/")+sequence+"/profile.png");
			
			try {
				FileInputStream fis = new FileInputStream(def_img);
				FileOutputStream fos = new FileOutputStream(copy_img);
				
				int fileByte = 0; 
	            while((fileByte = fis.read()) != -1) {
	                fos.write(fileByte);
	            }
	            fis.close();
	            fos.close();
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pet/pet_list");
		return mav;
	}
	
	@RequestMapping("/pet_update_com.do")
	public ModelAndView pet_update_com(MultipartFile blob, HttpServletRequest req, PetDTO dto) {
		
		dao.update_pet(dto);
		
		
		if(blob!=null) {
			copyInto(dto.getPet_idx(),blob, req);
		}
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pet/pet_list");
		return mav;
	}
	
	
	private void copyInto(int pet_idx, MultipartFile upload,HttpServletRequest req) {
		try {
			byte bytes[] = upload.getBytes(); //복사할 원본
			File petPath = new File(req.getSession().getServletContext().getRealPath("/pet/")+pet_idx);
			if(petPath.exists()==false) {
				petPath.mkdirs();
			}
			File outFile = new File(req.getSession().getServletContext().getRealPath("/pet/")+pet_idx+"/"+"profile.png"); // 복사될 빈종이

			FileOutputStream fos = new FileOutputStream(outFile);
			fos.write(bytes);
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/pet_update.do")
	public ModelAndView pet_update(String pet_idx) {
		
		ModelAndView mav = new ModelAndView();
		
		if(pet_idx==null || pet_idx=="") {
			mav.setViewName("redirect:pet_list.do");
		}else {
			PetDTO dto = dao.pet_info(pet_idx);
			mav.setViewName("pet/pet_update");
			mav.addObject("dto", dto);
		}
		return mav;
	}
	
	@RequestMapping("/pet_delete.do")
	public ModelAndView pet_delete(int pet_idx,HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		dao.delete_pet(pet_idx);
		
		File petPath = new File(req.getSession().getServletContext().getRealPath("/pet/")+pet_idx);
		if(petPath.exists()) {
			petPath.delete();
		}
		
		mav.setViewName("moreJson");
		return mav;
	}
}
