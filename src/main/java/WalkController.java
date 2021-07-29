package more.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import more.user.model.UserDAO;
import more.user.model.UserDTO;
import more.walk.model.WalkDAO;
import more.walk.model.WalkDAOImple;
import more.walk.model.WalkDTO;

import more.eat.model.*;
import more.pet.model.PetDAO;
import more.pet.model.PetDTO;

@Controller
public class WalkController {
	
	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private WalkDAO walkDao;
	
	@Autowired
	private EatDAO eatDao;
	
	@Autowired
	private PetDAO petDao;
	
	@RequestMapping("/app_html_test.do")
	public String testtest() {
		return "walk/app_test";
	}
	
	@RequestMapping("/m_walk_stats.do")
	public ModelAndView m_walk_stats_form(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		
		if(dto==null) {
			mav.setViewName("redirect:login.do");
		}else {
			int user_idx = dto.getUser_idx();
			List<Map<String, String>> pet_list = petDao.pet_list(user_idx);
			mav.setViewName("walk/m_walk_stats");
			mav.addObject("pet_list", pet_list);
		}
		return mav;
	}
	
	@RequestMapping("/walk_stats.do")
	public ModelAndView walk_stats_form(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		
		if(dto==null) {
			mav.setViewName("redirect:login.do");
		}else {
			int user_idx = dto.getUser_idx();
			List<Map<String, String>> pet_list = petDao.pet_list(user_idx);
			mav.setViewName("walk/walk_stats");
			mav.addObject("pet_list", pet_list);
		}
		return mav;
	}
	
	@RequestMapping("walk_stats_re.do")
	public ModelAndView walk_stats_re_form(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		
		if(dto==null) {
			mav.setViewName("redirect:login.do");
		}else {
			int user_idx = dto.getUser_idx();
			List<Map<String, String>> pet_list = petDao.pet_list(user_idx);
			mav.setViewName("walk/walk_stats_re");
			mav.addObject("pet_list", pet_list);
		}
		return mav;
	}
	
	@RequestMapping("/walk_get_total_stats.do")
	public ModelAndView walk_total_stats(String type, String date, String pet_idx, int  cp) {
		WalkDTO dto = walkDao.getTotalStats(type, date, pet_idx);
		List<WalkDTO> list = walkDao.getStats(pet_idx, cp, type, date);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("moreJson");
		mav.addObject("stats_list", list);
		mav.addObject("dto", dto);
		return mav;
	}
	
	@RequestMapping("/walk_get_eat_total_stats.do")
	public ModelAndView eat_total_stats(String type, String date, String pet_idx, int cp) {
		
		List<EatDTO> list = eatDao.getStats(pet_idx, cp, type, date);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("moreJson");
		mav.addObject("list", list);
		return mav;
	}
	
	@RequestMapping("walk_get_eat_cal_stat.do")
	public ModelAndView walk_get_eat_month_history(String pet_idx, String date) {
			List<Map<String, String>> list = eatDao.getTotalStats(date, pet_idx);
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("moreJson");
			mav.addObject("list", list);
			return mav;
	}
	
	@RequestMapping("walk_get_eat_week_chart.do")
	public ModelAndView get_eat_week_chart(String pet_idx, String date) {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String,String>> list = eatDao.getWeekChart(date, pet_idx);
		
		mav.setViewName("moreJson");
		mav.addObject("list", list);
		return mav;
	}
	
//	@RequestMapping("walk_get_stats.do")
//	public ModelAndView walk_get_stats(int pet_idx, int cp,String type, String date) {
//		
//		List<WalkDTO> list = walkDao.getStats(pet_idx, cp, type, date);
//		
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("stats_list", list);
//		mav.setViewName("moreJson");
//		return mav;
//	}
	
	@RequestMapping("walk_get_month_history.do")
	public ModelAndView walk_get_month_history(String pet_idx, String date) {
		List<Map<String, String>> list = walkDao.getMonthHistory(pet_idx, date);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("moreJson");
		mav.addObject("list", list);
		return mav;
		
	}
	
	
	//app 관련 컨트롤러
	@RequestMapping("/walk_app_main.do")
	public ModelAndView walk_app_main(HttpSession session) {
		UserDTO dto = (UserDTO)session.getAttribute("s_user");
		int user_idx = dto.getUser_idx();
		
		List<Map<String, String>> list = petDao.pet_list(user_idx);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("walk/walk_app_main");
		mav.addObject("list", list);
		return mav;
	}
	
	@RequestMapping("/walk_app_main_test.do")
	public ModelAndView walk_app_main_test(String sessionId,HttpServletResponse resp) {
		
		Cookie ck = new Cookie("JSESSIONID", sessionId);
		ck.setMaxAge(30000);
		resp.addCookie(ck);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:walk_app_main.do");
		return mav;
	}
	
	@RequestMapping("/walk_app_todayWalk.do")
	public ModelAndView todayWalk(String date, String pet_idx) {
		
		String result = walkDao.getTodayWalkTime(date, pet_idx);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("moreJson");
		mav.addObject("todayWalk", result);
		return mav;
	}
	
	@RequestMapping("/walk_app_walking.do")
	public ModelAndView walk_app_walking(String pet_idxs) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("walk/walk_app_walking");
		mav.addObject("pet_idxs", pet_idxs);
		return mav;
	}
	
	@RequestMapping("walk_app_uploadImg.do")
	public ModelAndView app_uploadImg(HttpServletRequest req) {
		String walk_idxs = req.getParameter("walk_idxs");
		int cam_num = Integer.parseInt(req.getParameter("cam_number"));
		
		MultipartHttpServletRequest mreq = (MultipartHttpServletRequest) req;
		
		String path = req.getSession().getServletContext().getRealPath("/pet/");
		String walk_idx[] = walk_idxs.split(",");
		for(int i=0; i<walk_idx.length; i++) {
			for(int j=0; j<cam_num; j++) {
				MultipartFile mf =  mreq.getFile("file["+j+"]");
				copyInto(walk_idx[i],mf,path,j);
			}
		}
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("moreJson");
		return mav;
	}
	
	private void copyInto(String walk_idx, MultipartFile upload,String path, int cam_num) {
		try {
			String fileName = upload.getOriginalFilename();
			int pos = fileName.lastIndexOf( "." );
			String ext = fileName.substring( pos + 1 );
			byte bytes[] = upload.getBytes(); //복사할 원본
			File petPath = new File(path+"walk_imgs/"+walk_idx);
			if(petPath.exists()==false) {
				petPath.mkdirs();
			}
			File outFile = new File(path+"walk_imgs/"+walk_idx+"/"+cam_num+"."+ext); // 복사될 빈종이

			FileOutputStream fos = new FileOutputStream(outFile);
			fos.write(bytes);
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/walk_app_stopWalking.do", method=RequestMethod.POST, produces="application/json; charset=utf8")
	public ModelAndView walk_app_stopWalking(@RequestBody String param,HttpServletRequest req) throws Exception {
		
		
		FileWriter fw=null;
		JSONParser parser = new JSONParser();
		JSONObject jsonParam = (JSONObject) parser.parse(param);
		JSONArray pet_idxs = (JSONArray) jsonParam.get("pet_idxs");
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		
		
		String distance = String.valueOf(jsonParam.get("distance"));
		String time = String.valueOf(jsonParam.get("time"));
		String startTime = String.valueOf(jsonParam.get("startTime"));
		String endTime = String.valueOf(jsonParam.get("endTime"));
		String userIdx = String.valueOf(jsonParam.get("userIdx"));
		
		
		Date startTime_d = new Date(Long.parseLong(startTime));
		Date endTime_d = new Date(Long.parseLong(endTime));
		
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
		
		String path_data = transFormat.format(startTime_d);
		String path_year = path_data.substring(0,4);
		String path_month = path_data.substring(4,6);
		String path_date = path_data.substring(6);
		
		
		WalkDTO dto = new WalkDTO(0, Integer.parseInt(userIdx), 0, startTime_d, endTime_d, Integer.parseInt(time), Integer.parseInt(distance), " ");
		
//		JSONArray walkInfo_ja = (JSONArray) jsonParam.get("walkInfo");
//		JSONArray walkInfo_total = new JSONArray();
//		walkInfo_total.add(walkInfo_ja);
//		JSONObject walkInfo_obj = new JSONObject();
//		walkInfo_obj.put("walkInfo", walkInfo_total);
//		
//		String gsonParam = gson.toJson(walkInfo_obj);
		
		String walk_idxs = "";
		for(int i=0; i<pet_idxs.size(); i++) {
			System.out.println(pet_idxs.get(i)+"pet_idxs"+i);
			dto.setWalk_pet_idx(Integer.parseInt(String.valueOf(pet_idxs.get(i))));
			int walk_idx = walkDao.saveWalk(dto);
			
			if(i==0) {
				walk_idxs = walk_idx+"";
			}else {
				walk_idxs += ","+walk_idx;
			}
			
			
			
			String path = req.getSession().getServletContext().getRealPath("/pet/"+pet_idxs.get(i)+"/walkInfo/"+path_year+"/"+path_month);
			File jsonFile = new File(path+"/"+path_date+".json");
			if(jsonFile.exists()) {
				Object obj = parser.parse(new FileReader(path+"/"+path_date+".json"));
				JSONObject e_json = (JSONObject) obj;
//				JSONArray e_ja = (JSONArray) e_json.get("walkInfo");
//				e_ja.add(jsonParam.get("walkInfo"));
//				
//				JSONObject walkInfo = new JSONObject();
//				walkInfo.put("walkInfo", e_ja);
				e_json.put(walk_idx+"",jsonParam.get("walkInfo"));
				
				//String e_gson = gson.toJson(walkInfo);
				String e_gson = gson.toJson(e_json);
				fw = new FileWriter(path+"/"+path_date+".json");
				fw.write(e_gson);
				fw.flush();
				
			}else {
				try {
					
					//여기
					JSONArray walkInfo_ja = (JSONArray) jsonParam.get("walkInfo");
//					JSONArray walkInfo_total = new JSONArray();
//					walkInfo_total.add(walkInfo_ja);
//					JSONObject walkInfo_obj = new JSONObject();
//					walkInfo_obj.put("walkInfo", walkInfo_total);
					
					JSONObject walkInfo_obj = new JSONObject();
					walkInfo_obj.put(walk_idx+"", walkInfo_ja);
					
					String gsonParam = gson.toJson(walkInfo_obj);
					//
					
					File jsonRoot = new File(path);
					jsonRoot.mkdirs();
					fw = new FileWriter(path+"/"+path_date+".json");
					fw.write(gsonParam);
					fw.flush();
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}finally {
					try {
						fw.close();
					} catch (Exception e2) {
						// TODO: handle exception
					}
				}
			}
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("moreJson");
		mav.addObject("walk_idxs", walk_idxs);
		return mav;
		
	}
	
	@RequestMapping("/walk_walking.do")
	public ModelAndView walk_walking(HttpServletRequest req,double lat, double lon,String pet_idxs) {
		HttpSession session = req.getSession();
		
		if(session.getAttribute("swalk")!=null) {
			session.removeAttribute("swalk");
		}
		
		//UserDTO dto = (UserDTO)session.getAttribute("s_user");
		UserDTO dto = new UserDTO();
		dto.setUser_idx(123);
		Map<String, String> swalk = new HashMap<String, String>();
		swalk.put("userIdx", dto.getUser_idx()+"");
		swalk.put("petIdx", pet_idxs);
		swalk.put("lat", lat+"");
		swalk.put("lon", lon+"");
		
		session.setAttribute("swalk", swalk);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("moreJson");
		return mav;
	}
	
	@RequestMapping("walk_getUsers.do")
	public ModelAndView walk_getUsers(HttpSession session) {
		ServletContext context = session.getServletContext();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("moreJson");
		return mav;
	}
	
	
	@RequestMapping("walk_app_eat.do")
	public ModelAndView walk_eat(int pet_idx, String pet_name) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("walk/walk_app_eat");
		mav.addObject("pet_idx", pet_idx);
		mav.addObject("pet_name", pet_name);
		return mav;
	}
	
	@RequestMapping("walk_app_eat_com.do")
	public ModelAndView walk_eat_com(@ModelAttribute EatDTO dto,String eat_date) throws Exception {
		
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd HH:mm");
		Date eat_time = transFormat.parse(eat_date);

		dto.setEat_time(eat_time);
		
		boolean result = eatDao.eatInsert(dto);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("moreJson");
		return mav;
	}
	
	@RequestMapping("walk_get_detail.do")
	public ModelAndView walk_get_detail(int walk_idx, int pet_idx, HttpServletRequest req) {
		
		JSONParser parser = new JSONParser();
		
		WalkDTO dto = walkDao.getWalkDetail(walk_idx);
		
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
		Date starttime_d = dto.getWalk_startTime();
		String path_data = transFormat.format(starttime_d);
		String path_year = path_data.substring(0,4);
		String path_month = path_data.substring(4,6);
		String path_date = path_data.substring(6);
		
		String path = req.getSession().getServletContext().getRealPath("/pet/"+pet_idx+"/walkInfo/"+path_year+"/"+path_month+"/"+path_date+".json");
		File jsonFile = new File(path);
		JSONArray j_arr = null;
		try {
			Object obj = parser.parse(new FileReader(path));
			JSONObject e_json = (JSONObject) obj;
			j_arr = (JSONArray) e_json.get(walk_idx+"");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("moreJson");
		mav.addObject("dto", dto);
		mav.addObject("walk_detail", j_arr);
		return mav;
	}
	
	
	
	
	@RequestMapping("/m_walk_app_login.do")
	public String app_login() {
		return "walk/m_walk_app_login";
	}
	
	@RequestMapping("/m_walk_app_login_com.do")
	public ModelAndView app_login_com(String username, String password,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		boolean result = userDao.loginCheck(username, password);
		
		if(result) {
			UserDTO dto = userDao.getUserInfo(username);
			session.setAttribute("s_user", dto);
			String sessionId = session.getId();
			mav.addObject("sessionId", sessionId);
		}
		
		mav.setViewName("moreJson");
		mav.addObject("result", result);
		return mav;
	}
	
	@RequestMapping("/m_walk_app_myPage.do")
	public ModelAndView walk_app_myPage(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		int user_idx = dto.getUser_idx();
		
		List<Map<String, String>> list= petDao.pet_list(user_idx);
		
		mav.setViewName("walk/walk_app_myPage");
		mav.addObject("dto", dto);
		mav.addObject("list", list);
		return mav;
	}
	
	@RequestMapping("/m_walk_app_petUpdate.do")
	public ModelAndView walk_app_petUpdate(String pet_idx) {
		ModelAndView mav = new ModelAndView();
		
		PetDTO dto = petDao.pet_info(pet_idx);
		
		mav.setViewName("walk/walk_app_petUpdate");
		mav.addObject("dto", dto);
		return mav;
	}
	
	@RequestMapping("/m_walk_app_userUpdate.do")
	public ModelAndView walk_app_userUpdate(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		mav.setViewName("walk/walk_app_userUpdate");
		mav.addObject("dto", dto);
		return mav;
	}
	
	@RequestMapping("/m_walk_app_petRegister.do")
	public ModelAndView walk_app_petRegister(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		UserDTO dto = (UserDTO) session.getAttribute("s_user");
		mav.setViewName("walk/walk_app_petRegister");
		mav.addObject("dto", dto);
		return mav;
	}
	
	@RequestMapping("/m_walk_app_petRegister_com.do")
	public ModelAndView petRegister_com(PetDTO dto, MultipartFile upload, HttpServletRequest req,HttpSession session) {
		UserDTO user = (UserDTO) session.getAttribute("s_user");
		int user_idx = user.getUser_idx();
		
		int pet_idx = petDao.pet_register(dto, user_idx);
		
		if(upload!=null) {
			copyIntoAppPet(pet_idx, upload, req);
		}else {
			File def_img = new File(req.getSession().getServletContext().getRealPath("/pet/default.png"));
			
			File copy_path = new File(req.getSession().getServletContext().getRealPath("/pet/")+pet_idx);
			if(!copy_path.exists()) {
				copy_path.mkdirs();
			}
			File copy_img = new File(req.getSession().getServletContext().getRealPath("/pet/")+pet_idx+"/profile.png");
			
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
		mav.setViewName("moreJson");
		return mav;
	}
	
	@RequestMapping("/m_walk_app_petUpdate_com.do")
	public ModelAndView petUpdate_com(PetDTO dto, MultipartFile upload, HttpServletRequest req,HttpSession session) {
		UserDTO user = (UserDTO) session.getAttribute("s_user");
		int user_idx = user.getUser_idx();
		
		int pet_idx = dto.getPet_idx();
		int result = petDao.update_pet(dto);
		
		if(upload!=null) {
			copyIntoAppPet(pet_idx, upload, req);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("moreJson");
		return mav;
	}
	
	
	private void copyIntoAppPet(int pet_idx, MultipartFile upload,HttpServletRequest req) {
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
	
	@RequestMapping("/m_walk_app_petDelete_com.do")
	public ModelAndView app_petDelete(int pet_idx, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		int result = petDao.delete_pet(pet_idx);
		
		File petPath = new File(req.getSession().getServletContext().getRealPath("/pet/")+pet_idx);
		if(petPath.exists()) {
			petPath.delete();
		}
		
		mav.setViewName("moreJson");
		return mav;
	}
	
}
