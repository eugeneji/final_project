package more.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import more.email.model.EmailDTO;
import more.user.model.UserDAO;
import more.user.model.UserDTO;

@Controller
public class IndexController {

	@Autowired
	private UserDAO userDao;

	@RequestMapping("/index.do")
	public String index(HttpServletResponse resp, HttpServletRequest req) {
		
		if(req.getSession().getAttribute("s_user") == null) {
			
			Cookie cks[] = req.getCookies();
			boolean first = true;
			if (cks != null) {
				for (int i = 0; i < cks.length; i++) {
					if (cks[i].getName().equals("firstVisit")) {
						first = false;
						break;
					}
				}
			}
			if (first) {
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String datestr = sdf.format(cal.getTime());
				Cookie ck = new Cookie("firstVisit", datestr.substring(2));
				ck.setMaxAge(60 * 60 * 24 * 30);
				resp.addCookie(ck);
			}
		}
		return "index";
	}

	@RequestMapping("/myPage.do")
	public ModelAndView myPage(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		if (dto == null) {
			mav.setViewName("redirect:login.do");
		} else {
			mav.addObject("user_idx", dto.getUser_idx());
			mav.setViewName("myUser/myPage");
		}

		return mav;
	}

	@RequestMapping(value = "/myInformation.do",method=RequestMethod.GET)
	public ModelAndView myInformation(HttpSession session) {
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		ModelAndView mav = new ModelAndView();
		mav.addObject("user_idx", dto.getUser_idx());
		mav.addObject("dto", dto);
		mav.setViewName("myUser/myInformation");
		return mav;
	}

	@RequestMapping(value="/userConfirm.do",method=RequestMethod.GET)
	public ModelAndView userConfirm(int user_idx) {
		ModelAndView mav = new ModelAndView();
		UserDTO dto = userDao.userConfirm(user_idx);
		mav.addObject("dto",dto);
		mav.setViewName("myUser/userConfirm");
		return mav;
	}
	@RequestMapping(value="/userEdit.do",method=RequestMethod.POST)
	public ModelAndView userEdit(UserDTO dto,int user_idx) {
		ModelAndView mav = new ModelAndView();
		int result = userDao.userEdit(dto);
		System.out.println("result:"+result);
		String msg=result>0?"수정 완료!":"수정 실패!";
		mav.addObject("msg", msg );
		mav.setViewName("myUser/myInformation");
		mav.addObject("dto",dto);
		return mav;
	
	}
	}

