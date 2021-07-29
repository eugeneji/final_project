package more.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import more.meeting_d.model.Meeting_dDAO;
import more.meeting_d.model.Meeting_dDTO;

@Controller
public class Meeting_d_Controller {

	@Autowired
	private Meeting_dDAO meetingDao;//자동주입
	
	
	@RequestMapping("/meeting_d_add.do")
	public ModelAndView meeting_d_add(Meeting_dDTO dto) {
		int result = meetingDao.meeting_d_add(dto);
	
		String msg = result>0?"등록":"실패";
		String gopage = "meeting.do";
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.addObject("gopage", gopage);
		mav.setViewName("meeting/meetingMsg");
		return mav;
	}
}
