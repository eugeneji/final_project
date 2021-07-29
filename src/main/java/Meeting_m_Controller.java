package more.controller;

import java.io.File;
import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonFormat;

import more.chat.model.*;
import more.meeting_m.model.*;

@Controller
public class Meeting_m_Controller {

	@Autowired
	private Meeting_mDAO meetingDao;//자동주입
	@Autowired
	private chatDAO chatDao;
	
	@RequestMapping("/meeting.do")
	public ModelAndView meeting(@RequestParam(value="cp",defaultValue = "1")int cp,
			HttpServletRequest req) {
		
		int totalCnt=meetingDao.meeting_m_getTotalCnt();
		int listSize=5;
		int pageSize=5;
		String pageStr=more.page.GuestPageModule
				.guestMakePage("meeting.do", totalCnt, cp, listSize, pageSize);
		
		List list = meetingDao.meeting_allList(cp, listSize);
		
//		File f = new File(req.getSession().getServletContext().getRealPath("/img/meeting/")+list.get(0));
//		list.add(f);}
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageStr", pageStr);
		mav.addObject("list", list);
		mav.setViewName("meeting/allContent");
		return mav;
	}
	
	@RequestMapping("/meeting_m.do")
//	@JsonFormat(pattern = "yyyy-MM-dd a HH:mm:ss", timezone="Asia/Seoul")
	public ModelAndView meeting_m_bbsList(
			@RequestParam(value="cp",defaultValue = "1")int cp,   //cp값이 없다면 ,1로 정의해라.
			@RequestParam(value="user_idx")int user_idx,
			HttpServletRequest req) {
		
		
		int totalCnt=meetingDao.meeting_m_getTotalCnt();
		int listSize=2;
		int pageSize=2;
		String pageStr=more.page.GuestPageModule
				.guestMakePage("meeting_m.do", totalCnt, cp, listSize, pageSize);
		List list = meetingDao.meeting_m_bbsList(cp,listSize,user_idx);
		List list_my = meetingDao.meeting_m_bbsList_my(cp,listSize,user_idx);
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageStr", pageStr);
		mav.addObject("list", list);
		mav.addObject("list_my", list_my);
		mav.setViewName("meeting/meeting_m");
		return mav;
	}
	
	@RequestMapping("/meeting_m_add.do")
	public ModelAndView before_m_add(Meeting_mDTO dto,
			@RequestParam(value="user_idx", defaultValue = "0")int user_idx) {
		dto= meetingDao.before_m_add(user_idx);
		
		//ModelAndView 방식
		ModelAndView mav = new ModelAndView();
		if(dto==null) {
			mav.addObject("msg", "로그인 후 이용해주세요.");
			mav.setViewName("meeting/meetingMsg");
		}else {
			mav.addObject("dto", dto);
			mav.setViewName("meeting/meeting_m_add");
		}
		return mav;
	}
	
	@RequestMapping(value="/meeting_m_addContent.do", method = RequestMethod.POST)
	public ModelAndView meeting_m_addContent(Meeting_mDTO dto,
			HttpServletRequest req,
			@RequestParam("upload")List<MultipartFile> uploads) {
		
		//db에 파일 이름들 가져오기 (임시,inset아님)
		String filenames = "";
		for(int i = 0; i < uploads.size(); i++) {
			filenames += uploads.get(i).getOriginalFilename();
			if(i!=uploads.size()-1) {
				filenames += ",";
			}
		}
		
		dto.setMeeting_m_file(filenames);
		
		int result = meetingDao.meeting_m_addContent(dto);
		
		RoomDTO rdto = new RoomDTO();
		rdto.setRoom_name(dto.getMeeting_m_subject());
		rdto.setUser_idx(""+dto.getUser_idx());
		rdto.setMeeting_m_idx(dto.getMeeting_m_idx());
		chatDao.createRooms(rdto);
		
		String msg = "모임이 등록되었습니다.";
		FileManagerController f = new  FileManagerController();
		
		for(int i = 0; i < uploads.size(); i++) {
			
			f.copyInto(uploads.get(i), req, result);
		}
		String gopage = "meeting.do";
		ModelAndView mav = new ModelAndView();
		mav.addObject("gopage", gopage);
		mav.addObject("msg", msg);
		mav.setViewName("meeting/meetingMsg");
		return mav;
	}
	
	@RequestMapping(value="/meeting_m_content.do", method = RequestMethod.GET)
	public ModelAndView meeting_m_content(Meeting_mDTO dto,
			Meeting_mDTO dto_my,
		@RequestParam(value="meeting_m_idx", defaultValue = "0")int meeting_m_idx,
		@RequestParam(value="user_idx")int user_idx) {
		dto = meetingDao.meeting_m_content(meeting_m_idx);
		dto_my = meetingDao.meeting_j_my(meeting_m_idx, user_idx);
		int count = meetingDao.meeting_m_count(meeting_m_idx);
		int count_d = meetingDao.meeting_d_count(meeting_m_idx);
		List list_j = meetingDao.meeting_j(meeting_m_idx);
		List list_d = meetingDao.meeting_d_list(meeting_m_idx);
		ModelAndView mav = new ModelAndView();
		if(dto==null) {
			mav.addObject("msg", "삭제된 게시글또는 잘못된 접근입니다.");
			mav.setViewName("meeting/meetingMsg");
		}else {
			mav.addObject("list_j", list_j);
			mav.addObject("dto", dto);
			mav.addObject("dto_my", dto_my);
			mav.addObject("count", count);
			mav.addObject("list_d", list_d);
			mav.addObject("count_d", count_d);
			mav.addObject("room_idx", meetingDao.getRoomIdx(meeting_m_idx));
			mav.setViewName("moreJson");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/yes.do", method = RequestMethod.GET)
	public ModelAndView yes(@RequestParam("user_idx")int user_idx,
			@RequestParam("meeting_m_idx")int meeting_m_idx) {
		
		int result = meetingDao.yes(user_idx,meeting_m_idx);
		String msg = result>0?"수락성공.":"수락실패.";
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.setViewName("moreJson");
		return mav;
	}
	
	@RequestMapping(value="/no.do", method = RequestMethod.GET)
	public ModelAndView no(Meeting_mDTO dto) {
		int result=meetingDao.no(dto);
		String msg = result>0?"거절성공.":"거절실패.";
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.setViewName("moreJson");
		return mav;
	}
	
	
	@RequestMapping(value="/meeting_m_push.do", method = RequestMethod.GET)
	public ModelAndView meeting_m_push(@RequestParam("meeting_m_idx")int meeting_m_idx,
			@RequestParam("user_idx")int user_idx) {
		int result=meetingDao.meeting_m_push(meeting_m_idx, user_idx);
		String msg = result>0?"요청을 보냈습니다. 내모임에서 확인하세요.":"요청보내기실패.";
		String gopage = "meeting.do";
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.addObject("gopage", gopage);
		mav.setViewName("meeting/meetingMsg");
		return mav;
	}
	
	@RequestMapping(value="/meeting_d_del.do", method = RequestMethod.GET)
	public ModelAndView meeting_d_del(Meeting_mDTO dto) {
		int result=meetingDao.meeting_d_del(dto);
		String msg_d = result>0?"삭제완료.":"삭제실패.";
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg_d", msg_d);
		mav.setViewName("moreJson");
		return mav;
	}
	
	@RequestMapping(value="/meeting_d_update.do", method = RequestMethod.POST)
	public ModelAndView meeting_d_update(Meeting_mDTO dto) {
		int result=meetingDao.meeting_d_update(dto);
		String msg = result>0?"수정되었습니다.":"수정이 실패하였습니다.";
		String gopage = "meeting.do";
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.addObject("gopage", gopage);
		mav.setViewName("meeting/meetingMsg");
		return mav;
	}
}
