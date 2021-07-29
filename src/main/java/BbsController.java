package more.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import more.bbs.model.BbsDAO;
import more.bbs.model.BbsDTO;
import more.comment.model.CommentDAO;
import more.comment.model.CommentDTO;
import more.email.model.EmailDAO;
import more.email.model.EmailDTO;

@Controller
@EnableWebMvc
public class BbsController {

	@Autowired
	private BbsDAO bbsDao;
	@Autowired
	private CommentDAO comDao;
	@Autowired
	private EmailDAO emailDao;

	@RequestMapping("/lostPet.do")
	public String lostPetMain() {
		return "bbs/lostPet";
	}

	@RequestMapping("/petCenter.do")
	public String petCenter() {
		return "bbs/petCenter";
	}

	@RequestMapping("/reportBbsList.do")
	public ModelAndView reportBbsList(@RequestParam(value = "cp", defaultValue = "1") int cp) {

		int totalCnt = bbsDao.getTotalCnt(5);
		int listSize = 5;
		int pageSize = 5;
		String pageStr = more.paging.pagingModule.makePage("reportBbsList.do", totalCnt, cp, listSize, pageSize);

		List list = bbsDao.reportBbsList(cp, listSize);

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.addObject("pageStr", pageStr);
		mav.setViewName("bbs/reportBbsList");
		return mav;
	}

	@RequestMapping(value = "/reportBbsWrite.do", method = RequestMethod.GET)
	public String reportBbsWriteForm() {
		return "bbs/reportBbsWrite";
	}

	@RequestMapping(value = "/reportBbsWrite.do", method = RequestMethod.POST)
	public ModelAndView reportBbsWriteSubmit(BbsDTO dto) {

		int result = bbsDao.reportBbsWrite(dto);
		String msg = result > 0 ? "작성 완료!" : "작성 실패!";
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.setViewName("bbs/bbsMsg");
		return mav;
	}

	@RequestMapping(value = "/reportBbsContent.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public ModelAndView reportBbsContent(@RequestParam(value = "bbs_idx", defaultValue = "0") int bbs_idx) {

		BbsDTO dto = bbsDao.reportBbsContent(bbs_idx);
		ArrayList<CommentDTO> commentList = (ArrayList<CommentDTO>) comDao.commentList(bbs_idx);
		// 조회수
		bbsDao.reportBbsReadnum(bbs_idx);
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", dto);
		mav.addObject("commentList", commentList);
		mav.setViewName("moreJson");
		return mav;

	}

	// 수정
	@RequestMapping(value = "/reportBbsEdit.do", method = RequestMethod.GET)
	public ModelAndView reportBbsEditForm(int bbs_idx) {
		BbsDTO dto = bbsDao.reportBbsContent(bbs_idx);
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", dto);
		mav.setViewName("bbs/reportBbsEdit");
		return mav;
	}

	@RequestMapping(value = "/reportBbsEdit.do", method = RequestMethod.POST)
	public ModelAndView reportBbsEdit(BbsDTO dto) {
		int result = bbsDao.reportBbsEdit(dto);
		String msg = result > 0 ? "수정 완료!" : "수정 실패!";
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.setViewName("bbs/bbsMsg");
		return mav;
	}

	@RequestMapping("/reportBbsDel.do")
	public ModelAndView reportBbsDel(@RequestParam(value = "bbs_idx") int bbs_idx) {

		ModelAndView mav = new ModelAndView();
		int count = bbsDao.reportBbsDel(bbs_idx);
		String msg = count == 1 ? "삭제완료" : "삭제실패";
		mav.addObject("msg", msg);
		mav.setViewName("bbs/reportBbsList");
		return mav;

	}

	// 강아지,고양이를 찾습니다.
	@RequestMapping("/findBbsList.do")
	public ModelAndView findBbsList(@RequestParam(value = "cp", defaultValue = "1") int cp) {

		int totalCnt = bbsDao.getTotalCnt(3);
		int listSize = 5;
		int pageSize = 5;
		String pageStr = more.paging.pagingModule.makePage("findBbsList.do", totalCnt, cp, listSize, pageSize);

		List list = bbsDao.findBbsList(cp, listSize);

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.addObject("pageStr", pageStr);
		mav.setViewName("bbs/findBbsList");
		return mav;
	}

	@RequestMapping(value = "/findBbsWrite.do", method = RequestMethod.GET)
	public String findBbsWriteForm() {
		return "bbs/findBbsWrite";
	}

	@RequestMapping(value = "/findBbsWrite.do", method = RequestMethod.POST)
	public ModelAndView findBbsWriteSubmit(BbsDTO dto) {

		int result = bbsDao.findBbsWrite(dto);
		String msg = result > 0 ? "작성 완료!" : "작성 실패!";
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.setViewName("bbs/findMsg");
		return mav;
	}

	@RequestMapping(value = "/findBbsContent.do")
	public ModelAndView findBbsContent(@RequestParam(value = "bbs_idx", defaultValue = "0") int bbs_idx) {
		BbsDTO dto = bbsDao.findBbsContent(bbs_idx);
		ArrayList<CommentDTO> commentList = (ArrayList<CommentDTO>) comDao.commentList(bbs_idx);

		dto = bbsDao.findBbsContent(bbs_idx);
		bbsDao.findBbsReadnum(bbs_idx);
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", dto);
		mav.setViewName("moreJson");
		return mav;

	}

	// 수정
	@RequestMapping(value = "/findBbsEdit.do", method = RequestMethod.GET)
	public ModelAndView findBbsEditForm(int bbs_idx) {
		BbsDTO dto = bbsDao.findBbsContent(bbs_idx);
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", dto);
		mav.setViewName("bbs/findBbsEdit");
		return mav;
	}

	@RequestMapping(value = "/findBbsEdit.do", method = RequestMethod.POST)
	public ModelAndView findBbsEdit(BbsDTO dto) {
		int result = bbsDao.findBbsEdit(dto);
		String msg = result > 0 ? "수정 완료!" : "수정 실패!";
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.setViewName("bbs/bbsMsg2");
		return mav;
	}

	@RequestMapping("/findBbsDel.do")
	public ModelAndView findBbsDel(@RequestParam(value = "bbs_idx") int bbs_idx) {

		ModelAndView mav = new ModelAndView();
		int count = bbsDao.findBbsDel(bbs_idx);
		String msg = count == 1 ? "삭제완료" : "삭제실패";
		mav.addObject("msg", msg);
		mav.setViewName("bbs/findBbsList");
		return mav;

	}
}
//   
//	private void copyInto( MultipartFile upload, HttpServletRequest req) {
//		try {
//			byte bytes[] = upload.getBytes(); //복사할 원본
//			File petPath = new File(req.getSession().getServletContext().getRealPath("/bbsimages/"));
//			if(petPath.exists()==false) {
//				petPath.mkdirs();
//			}
//			File outFile = new File(req.getSession().getServletContext().getRealPath("/bbsimages/")+"/"+upload.getName()); // 복사될 빈종이
//
//			FileOutputStream fos = new FileOutputStream(outFile);
//			fos.write(bytes);
//			fos.close();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
//}