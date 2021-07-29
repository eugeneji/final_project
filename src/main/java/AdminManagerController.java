package more.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import more.adminManager.model.AdminManagerDAO;
import more.adminManager.model.AdminManagerDTO;
import more.meeting_m.model.Meeting_mDAO;

@Controller
public class AdminManagerController {

	@Autowired
	private AdminManagerDAO adminDao;
	@Autowired
	private Meeting_mDAO meeting_mDao;
	
	@RequestMapping("/userManager.do")
	public ModelAndView userManager(@RequestParam(value="cp",defaultValue = "1")int cp,
			HttpServletRequest req) {
		
		int totalCnt = adminDao.user_getTotalCnt();
		int listSize=10;
		int pageSize=10;
		String pageStr=more.page.GuestPageModule
				.guestMakePage("userManager.do", totalCnt, cp, listSize, pageSize);
		List list = adminDao.userManager(cp, listSize);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageStr", pageStr);
		mav.addObject("list", list);
		mav.setViewName("admin/user/userPage");
		return mav;
	}
	
	@RequestMapping(value="/userView.do", method = RequestMethod.GET)
	public ModelAndView userView(@RequestParam("user_idx")int user_idx,
			AdminManagerDTO dto) {
		
		dto = adminDao.userView(user_idx);
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", dto);
		mav.setViewName("admin/user/userView");
		return mav;
	}
	
	@RequestMapping("/userBen.do")
	public ModelAndView userBen(@RequestParam("user_idx")int user_idx,
			AdminManagerDTO dto) {
		
		int result = adminDao.userBen(user_idx);
		dto = adminDao.userView(user_idx);
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", dto);
		mav.setViewName("admin/user/userView");
		return mav;
	}
	
		@RequestMapping("/userBenCancel.do")
	public ModelAndView userBenCancel(@RequestParam("user_idx")int user_idx,
			AdminManagerDTO dto) {
		
		int result = adminDao.userBenCancel(user_idx);
		dto = adminDao.userView(user_idx);
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", dto);
		mav.setViewName("admin/user/userView");
		return mav;
	}
		
		@RequestMapping("/bbsManager.do")
		public ModelAndView bbsManager(@RequestParam(value="cp",defaultValue = "1")int cp,
				HttpServletRequest req) {
			
			int totalCnt = adminDao.bbsManager();
			int listSize=10;
			int pageSize=10;
			String pageStr=more.page.GuestPageModule
					.guestMakePage("userManager.do", totalCnt, cp, listSize, pageSize);
			List list_m = meeting_mDao.meeting_allList(cp, listSize);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("pageStr", pageStr);
			mav.addObject("list_m", list_m);
			mav.setViewName("admin/user/bbsManager");
			return mav;
		}	
}
