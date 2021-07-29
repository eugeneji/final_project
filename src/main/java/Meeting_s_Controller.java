package more.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonFormat;

import more.meeting_s.model.*;

@Controller
public class Meeting_s_Controller {

	@Autowired
	private Meeting_sDAO meetingDao;//자동주입
	
	@RequestMapping("/meeting_s.do")
//	@JsonFormat(pattern = "yyyy-MM-dd a HH:mm:ss", timezone="Asia/Seoul")
	public ModelAndView meeting_s_bbsList(
			@RequestParam(value="cp",defaultValue = "1")int cp) {//cp값이 없다면 ,1로 정의해라.
		
		int totalCnt=meetingDao.meeting_s_getTotalCnt();
		int listSize=2;
		int pageSize=2;
		String pageStr=more.page.GuestPageModule
				.guestMakePage("meeting_s.do", totalCnt, cp, listSize, pageSize);
		List list = meetingDao.meeting_s_bbsList(cp,listSize);
		
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageStr", pageStr);
		mav.addObject("list", list);
		
		mav.setViewName("meeting/meeting_s");
		return mav;
	}
	
	
	@RequestMapping(value="/meeting_m_add.do", method = RequestMethod.GET)//이름이같은 겟방식
	public String meeting_m_add() {
		return "meeting/meeting_m_add";
	}
	
	@RequestMapping(value="/meeting_s_content.do",produces = "text/plain;charset=utf-8")
	@ResponseBody
	public ModelAndView joinContent(Meeting_sDTO dto,
			@RequestParam(value="meeting_s_idx", defaultValue = "0")int meeting_s_idx) { //idx가 값이 없다면 0으로 정의해줄거야.
//		int result = meetingDao.readnum(idx);
		dto=meetingDao.joinContent(meeting_s_idx);

		//ModelAndView 방식
		ModelAndView mav = new ModelAndView();
		if(dto==null) {
			mav.addObject("msg", "삭제된 게시글또는 잘못된 접근입니다.");
			mav.setViewName("meeting/meetingMsg");
		}else {
			mav.addObject("dto", dto);
			mav.setViewName("moreJson");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/meeting_s_write.do", method = RequestMethod.GET)//이름이같은 겟방식
	public String bbsWrite() {
		return "meeting/meeting_s_write";
	}
	
	@RequestMapping(value="/meeting_s_write_add.do", method = RequestMethod.POST)
	public ModelAndView meeting_s_write(Meeting_sDTO dto) {
		int result = meetingDao.meeting_s_write_add(dto);
		String msg = result>0?"등록완료.":"등록실패.";
		String gopage="meeting_s.do";
		ModelAndView mav = new ModelAndView();
		mav.addObject("gopage",gopage);
		mav.addObject("msg",msg);
		mav.setViewName("meeting/meetingMsg");
		return mav;
	}
	
	@RequestMapping("/meeting_s_contentDel.do")
	public ModelAndView meeting_s_contentDel(@RequestParam("meeting_s_idx")int meeting_s_idx) {
		int result = meetingDao.meeting_s_contentDel(meeting_s_idx);
		String msg = result>0?"삭제완료.":"삭제실패.";
		ModelAndView mav = new ModelAndView();
		String gopage = "meeting_s.do";
		mav.addObject("gopage", gopage);
		mav.addObject("msg", msg);
		mav.setViewName("meeting/meetingMsg");
		return mav;
	}
	
	@RequestMapping("/meeting_s_update.do")
	public ModelAndView meeting_s_update(Meeting_sDTO dto) {
		int result = meetingDao.meeting_s_update(dto);
		String msg = result>0?"수정완료.":"수정실패.";
		ModelAndView mav = new ModelAndView();
		String gopage = "meeting_s.do";
		mav.addObject("gopage", gopage);
		mav.addObject("msg", msg);
		mav.setViewName("meeting/meetingMsg");
		return mav;
	}
	
	
}
