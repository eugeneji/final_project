package more.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import more.comment.model.CommentDAO;
import more.comment.model.CommentDTO;
import more.user.model.UserDTO;

@Controller
@EnableWebMvc
public class CommentController {

	@Autowired
	private CommentDAO comDao;
	
	@RequestMapping("/reportReBbsWrite.do")
	public ModelAndView reportReBbsWrite(CommentDTO dto, HttpSession session) {
		
		UserDTO udto = (UserDTO)session.getAttribute("s_user");
		dto.setComment_writer(udto.getUser_nickname());
		dto.setUser_idx(udto.getUser_idx());
		int result=comDao.reportReBbsWrite(dto);
		String msg=result>0?"등록완료!":"등록실패!";
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.addObject("newComment",dto);
		mav.setViewName("moreJson");
		return mav;
	}
}
