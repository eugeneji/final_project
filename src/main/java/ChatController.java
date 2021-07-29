package more.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import more.chat.model.*;
import more.sitter.model.SitterDTO;
import more.user.model.UserDTO;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@EnableWebMvc
public class ChatController {

	@Autowired
	chatDAO chatDao;
	
	@RequestMapping("chat.do")
	public ModelAndView chat() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("chat/chat_main");
		return mav;
	}
	
	@RequestMapping("getAlarmList.do")
	@ResponseBody
	public Map getAlarmList(String user_idx){
		
		Map<String, List> map = new HashMap<String, List>();
		map.put("alarmList", chatDao.getAlarmList(user_idx));
		return map;
	}
	
	@RequestMapping("getRoomList.do")
	@ResponseBody
	public Map getRoomList(String user_idx){
		System.out.println(user_idx);
		Map<String, List> map = new HashMap<String, List>();
		map.put("roomList", chatDao.getRoomList(user_idx));
		return map;
	}
	
	@RequestMapping("getMessageList.do")
	@ResponseBody
	public Map getMessageList(String room_idx, HttpSession session){
		
		Map<String, String> user = new HashMap<String, String>();
		user.put("room_idx", room_idx);
		user.put("user_idx", ""+((UserDTO)session.getAttribute("s_user")).getUser_idx());
		chatDao.updateJoinDate2(user);
		
		Map<String, List> map = new HashMap<String, List>();
		
		map.put("messageList", chatDao.getMessageList(room_idx));
		return map;
	}
	
	@RequestMapping(value="chatImage.do", method = RequestMethod.POST )
	@ResponseBody
	public Map chatImage(RoomDTO dto, HttpServletRequest req) {
		
		dto.setImg_name(dto.getImg_name().replaceAll(":", "").trim());
		System.out.println(dto);
		copyInto(dto.getRoom_idx(), "/chat/", "/"+dto.getImg_name()+".png", dto.getUpload(), req);
		Map<String,String> map = new HashMap<String, String>();
		map.put("message", dto.getImg_name());
		map.put("type","img");
		
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
	
	@RequestMapping("/filedown2.do")
	public ModelAndView fileDownload(int room_idx,String filename,HttpServletRequest req) {
		
		File file = new File(req.getSession().getServletContext().getRealPath("/chat/")+room_idx+"/"+filename);
		ModelAndView mav = new ModelAndView();
		mav.addObject("downloadFile", file);
		mav.setViewName("moreDown");
		return mav;
	}
}
