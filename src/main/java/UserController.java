package more.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import more.bbs.model.BbsDTO;
import more.email.model.EmailDAO;
import more.email.model.EmailDTO;
import more.user.model.*;

@Controller
@EnableWebMvc
public class UserController {

	@Autowired
	private UserDAO userDao;
	@Autowired
	EmailDAO emailDao;
	
	@RequestMapping(value = "userJoin.do", method = RequestMethod.GET)
	public String userJoinForm() {
		return "user/userJoin";
	}

	@RequestMapping(value="userJoin.do", method=RequestMethod.POST)
	public ModelAndView userJoinSubmit(UserDTO dto, MultipartFile blob, HttpServletRequest req) {
		
		if(blob!=null) {
			dto.setUser_img("InUserFolder");
		}else {
			dto.setUser_img("default");
		}
		int user_idx=userDao.userJoin(dto);
		
		if(blob!=null) {
			copyInto(user_idx, blob, req);
		}
		ModelAndView mav= new ModelAndView();
		
//		String msg=result>0?"회원가입 완료!":"회원가입 실패!";
//		mav.addObject("msg", msg);
//		mav.addObject("gourl", "index.do");
//		mav.setViewName("user/userMsg");
		
		mav.setViewName("moreJson");
		return mav;
	}
	
	private void copyInto(int user_idx, MultipartFile upload, HttpServletRequest req) {
		try {
			byte bytes[] = upload.getBytes(); //복사할 원본
			File petPath = new File(req.getSession().getServletContext().getRealPath("/user/")+user_idx);
			if(petPath.exists()==false) {
				petPath.mkdirs();
			}
			File outFile = new File(req.getSession().getServletContext().getRealPath("/user/")+user_idx+"/"+"profile.png"); // 복사될 빈종이

			FileOutputStream fos = new FileOutputStream(outFile);
			fos.write(bytes);
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/login.do")
	public String loginForm() {
		return "user/login";
	}

	@RequestMapping(value = "/loginCheck.do", method = RequestMethod.POST)
	public ModelAndView loginCheck(@RequestParam(value = "user_email", defaultValue = "") String user_email,
			@RequestParam(value = "user_pwd", defaultValue = "") String user_pwd, HttpSession session,
			HttpServletResponse resp, @RequestParam(value = "saveid", required = false) String saveid) {

		boolean result = userDao.loginCheck(user_email, user_pwd);
		ModelAndView mav = new ModelAndView();

		if (saveid == null) {
			Cookie ck = new Cookie("saveid", user_email);
			ck.setMaxAge(0);
			resp.addCookie(ck);
		} else {
			Cookie ck = new Cookie("saveid", user_email);
			ck.setMaxAge(60 * 60 * 24 * 30);
			resp.addCookie(ck);
		}

		if (!result) {
			mav.addObject("msg", "잘못된 아이디 또는 비밀번호 입니다.");
			mav.addObject("gourl", "login.do");
			mav.setViewName("user/loginMsg");

		} else {
			UserDTO dto = userDao.getUserInfo(user_email);
			mav.addObject("msg", dto.getUser_nickname() + "님 안녕하세요?");
			mav.setViewName("index");
			session.setAttribute("s_user", dto);

		}
		return mav;
	}

	@RequestMapping("/logout.do")
	public String logoutForm(HttpServletRequest req) {

		HttpSession session = req.getSession();
		session.invalidate();
		return "redirect:/index.do";
	}

	@RequestMapping("/idCheck.do")
	public ModelAndView idCheckForm(@RequestParam String user_email) {
		ModelAndView mav = new ModelAndView();
		boolean result = userDao.idCheck(user_email);
		if (result) {
			mav.addObject("msg", "중복된 이메일 입니다.");
			mav.addObject("result", true);
		} else {
			mav.addObject("msg", "사용가능한 이메일 입니다!");
			mav.addObject("result", false);
		}
		mav.setViewName("moreJson");

		return mav;
	}
	@RequestMapping(value="/findId.do", method = RequestMethod.GET)
	public String userFindIdPage() {
		
		return "user/findId";
	}
	
	@RequestMapping(value="/findId_ok.do", method = RequestMethod.POST)
	public ModelAndView findId(UserDTO dto){
	ModelAndView mav = new ModelAndView();
	String result= userDao.findId(dto);
	System.out.println("result:"+result);
	if(result==null) {
		mav.addObject("msg", "존재하지 않는 아이디 입니다.");
		mav.addObject("gourl", "findId.do");
		mav.setViewName("user/loginMsg");
	}else {
	mav.addObject("user_email", result);
	mav.setViewName("user/idClear");
	
	}return mav;
}
	@RequestMapping("/findPwd.do")
	public String findPwdForm() {
		return "user/findPwd";
	}

	@RequestMapping("/findPwd_ok.do")
	public ModelAndView findpwdFromSubmit(@RequestParam(required = false) String user_email) {
		int result = userDao.findPwd(user_email);
		ModelAndView mav = new ModelAndView();
		
		//난수생성
		int num =(int)(Math.random()*1000000)+1;
		
		if (result<=0) {
			mav.addObject("msg", "가입된 아이디가 없거나 잘못된 아이디 입니다.");
			mav.addObject("gourl", "findPwd.do");
			mav.setViewName("user/loginMsg");
		} else if (result>0) {
			
			EmailDTO emailDto = new EmailDTO();
			emailDto.setSenderName("모어펫");
			emailDto.setSenderMail("kruise1157@gmail.com");
			emailDto.setReceiveMail(user_email);
			emailDto.setSubject("고객님의 임시비밀번호 입니다.");
			emailDto.setMessage("임시비밀번호는["+num+"]입니다.");
			try {
				emailDao.sendMail(emailDto);
			}catch (Exception e) {
				e.printStackTrace();
			}
			mav.addObject("num",num);
			mav.addObject("user_idx",result);
			mav.setViewName("user/tpNumber");
		}return mav;
	}
	@RequestMapping("/tpNumber.do")
	public ModelAndView tpNumber() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/pwdUpdate");
		return mav;
	}
	
	
	@RequestMapping("/pwdUpdateForm.do")
		public ModelAndView pwdUpdateForm(@RequestParam("user_idx")int user_idx) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("user_idx", user_idx);
		mav.setViewName("user/pwdUpdate");
			return mav;
		
	}
	 @RequestMapping(value="/pwdUpdate.do")
    public ModelAndView pwdUpdate(UserDTO dto) {
		 System.out.println(dto.getUser_pwd());
		 System.out.println(dto.getUser_idx());
	   int result = userDao.pwdUpdate(dto);
	   System.out.println(result);
       ModelAndView mav = new ModelAndView();
       mav.addObject("msg","비밀번호가 변경되었습니다!");
       mav.setViewName("user/pwdClear");
       return mav;
    }

}