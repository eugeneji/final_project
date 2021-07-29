package more.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.type.BigIntegerTypeHandler;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import net.sf.json.JSONArray;
import more.adminManager.model.AdminManagerDAO;
import more.cate.model.cateDao;
import more.chart.model.areaChartDTO;
import more.chart.model.bestUserChartDTO;
import more.chart.model.periodChartDTO;
import more.chart.model.shopChartDAO;
import more.chart.model.shopChartDTO;
import more.chart.model.totalChartDTO;
import more.email.model.EmailDAO;
import more.email.model.EmailDTO;
import more.imgupload.UploadImg;
import more.itemandcate.model.itemandcateDTO;
import more.order.model.adminOrderDAO;
import more.order.model.orderDTO;
import more.order.model.orderItemDTO;
import more.shopitem.model.shopitemDAO;
import more.shopitem.model.shopitemDTO;
import more.stock.model.stockDAO;
import more.stock.model.stockDTO;

@Controller
@EnableWebMvc
public class shopAdminController {
	
	@Autowired
	private cateDao catedao;
	@Autowired
	private shopitemDAO shopdao;
	@Autowired
	private stockDAO stockdao;
	@Autowired
	private adminOrderDAO aodao;
	@Autowired
	EmailDAO emailDao;
	@Autowired
	private shopChartDAO chartdao;
  @Autowired
	private AdminManagerDAO adminDao;

	
	//관리자 페이지 이동
	@RequestMapping("/adminPage.do")
	public ModelAndView adminPage() {
		int count = adminDao.user_getTotalCnt();
		int bbsManager = adminDao.bbsManager();
		ModelAndView mav = new ModelAndView();
		mav.addObject("count", count);
		mav.addObject("bbsManager", bbsManager);
		mav.setViewName("admin/shop/adminPage");
		return mav;
	}
	//아이템 조회 화면 이동
	@RequestMapping("/selectItemForm.do")
	public ModelAndView selectItemForm() throws Exception {
		
		List cate = catedao.loadCategory();
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("jscate", JSONArray.fromObject(cate));
		mav.addObject("cate", cate);
		mav.setViewName("admin/shop/selectItem");
		return mav;
	}
	//아이템 검색 화면 이동
	   //아이템 검색 화면 이동
	   @RequestMapping(value = "/selectItemListAdmin.do" , produces="application/json; charset=utf8")
	   @ResponseBody
	   public Map selectItemList(
	         @RequestBody Map<String, Object> data) throws Exception {
	      
	      int cate_code = Integer.parseInt(String.valueOf(data.get("cate_code"))); 
	      int cate_code2 = Integer.parseInt(String.valueOf(data.get("cate_code2"))); 
	      String item_name = String.valueOf(data.get("item_name"));
	      String selectOption = String.valueOf(data.get("selectOption"));
	      int cp = Integer.parseInt(String.valueOf(data.get("cp"))); 
	      
	      System.out.println(cate_code);
	      System.out.println(cate_code2);
	      System.out.println(item_name);
	      System.out.println(selectOption);
	   if(cate_code2!=1000) {
	      cate_code=cate_code2;
	   }
	   int listSize = 3;
	   int pageSize = 3;
	      
	   int start=(cp-1)*listSize+1;
	   int end= cp*listSize;
	   
	   Map map = new HashMap();
	   item_name = "%"+item_name+"%";
	   map.put("cate_code", cate_code);
	   map.put("item_name", item_name);
	   map.put("selectOption", selectOption);
	   map.put("start", start);
	   map.put("end", end);
	   
	   int totalCnt = shopdao.totalCount(map);
	   
	   String paging = more.paging.pagingModule.makePage("selectItemListAdmin.do", totalCnt, cp, listSize, pageSize);
	   System.out.println(paging);
	   List list = shopdao.selectitemList(map);

	   Map resultMap = new HashMap();
	   resultMap.put("list", list);
	   resultMap.put("paging", paging);
	      return resultMap;
	   }
	   
	
	
	@RequestMapping("/stockManageForm.do")
	public ModelAndView stockManageForm() throws Exception {
List cate = catedao.loadCategory();
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("jscate", JSONArray.fromObject(cate));
		mav.addObject("cate", cate);
		mav.setViewName("admin/shop/stockSelect");
		return mav;
	}
	
	
	@RequestMapping("/updateStock.do")
	@ResponseBody
	public Map stockUpdateForm(stockDTO dto,
			@RequestParam("item_stock")int item_stock) throws Exception {
		
		int result = stockdao.insertStock(dto);
		System.out.println(dto.getStock_cause());
		System.out.println(dto.getStock_type());
		System.out.println(dto.getStock_unit());
		System.out.println(dto.getStock_unitcost());
		System.out.println(dto.getItem_idx());
		int item_idx = dto.getItem_idx();
		shopdao.updateStock(item_idx, item_stock);
		String msg = result>0?"반영 되었습니다.":"문제가 발생했습니다.";
	Map map = new HashMap();
	map.put("msg", msg);
		return map;
	}
		
		@RequestMapping("/insertItemForm.do")
		public ModelAndView insertItemForm() throws Exception {
			
			List cate = catedao.loadCategory();
			
			ModelAndView mav = new ModelAndView();
			
			mav.addObject("jscate", JSONArray.fromObject(cate));
			mav.addObject("cate", cate);
			mav.setViewName("admin/shop/insertItem");
			return mav;
		}
		
		
		@RequestMapping("/insertItem.do")
		public ModelAndView insertItem(
				MultipartHttpServletRequest req
				) throws Exception {

			String subName;
			int post;
			String ext;
			String uploadPath;
			
			String cate_code = req.getParameter("cate_code");
			String item_name = req.getParameter("item_name");
			String item_info = req.getParameter("item_info");
			int item_price = Integer.parseInt(req.getParameter("item_price"));
			String item_regid = req.getParameter("item_regid");
			String item_tf = req.getParameter("item_tf").toUpperCase();
			
			shopitemDTO dto = new shopitemDTO();
			
			dto.setCate_code(cate_code);
			dto.setItem_info(item_info);
			dto.setItem_name(item_name);
			dto.setItem_price(item_price);
			dto.setItem_regid(item_regid);
			dto.setItem_tf(item_tf.toUpperCase());

			MultipartFile mainImg = req.getFile("item_mainimg");

			int item_idx = shopdao.insertItem(dto);
			
			uploadPath = req.getRealPath("itemImg\\");

			//폴더 중복 없이 제공해주기
			String saveDB = UploadImg.makeDir(uploadPath, item_idx);
			//생성한 폴더에 파일 만들기
			String realPath = uploadPath+saveDB;
			String saveDBPath = UploadImg.uploadMainImg(mainImg, realPath, saveDB);

			dto.setItem_mainimg(saveDBPath);
			dto.setItem_idx(item_idx);
			int result = shopdao.updateImg(dto);
			
			int sub_tf = Integer.parseInt(req.getParameter("subimg_tf"));
			if(sub_tf>0) {

				List<MultipartFile> filesuploads = req.getFiles("item_subimg");
				UploadImg.uploadSubImg(filesuploads, realPath);

			}
			
			

			String msg = result>0?"등록을 완료했습니다.":"등록에 실패했습니다.";

			ModelAndView mav = new ModelAndView();
			mav.addObject("msg", msg);
			mav.addObject("goPage", "adminPage.do");
			mav.setViewName("admin/shop/msg");
			return mav;

			//상품 조회할 떄 아이템 이름 폴더로 접근해서 파일목록 가져오기

			/**d이건 파일 폴더로 만들어서 테이블에 저장하는 방법
			 * 근데 썸네일만 할지 이거도 할지 결정해야댐
			 * */		
			
		
		}
		
		@RequestMapping("/updateItemForm.do")
		public ModelAndView updateItemForm(
				@RequestParam("item_idx")int item_idx,
				HttpServletRequest req
				) throws Exception {

			List cate = catedao.loadCategory();
			itemandcateDTO item = shopdao.selectItemDetail(item_idx);
			ModelAndView mav = new ModelAndView();

			String thumsPath_s = item.getItem_mainimg();
			int post = thumsPath_s.indexOf("/t");
			String thumsPath = thumsPath_s.substring(0, post);
			String fileDir=req.getRealPath("itemImg\\"+thumsPath);
			System.out.println(thumsPath);
			int last = thumsPath_s.lastIndexOf("/t_");
			String realthum = thumsPath_s.substring(last+3, thumsPath_s.length());
			File f=new File(fileDir); //폴더라는 전재
			File fs[]=f.listFiles();
			List<File> fileNames = new ArrayList<File>();
			for(int i=0;i<fs.length;i++){
				if(fs[i].isFile()) {
					fileNames.add(fs[i]);
				}

			}

			mav.addObject("jscate", JSONArray.fromObject(cate));
			mav.addObject("cate", cate);
			mav.addObject("item", item);
			mav.addObject("thum", realthum);
			mav.addObject("path", thumsPath);
			mav.addObject("imgs", fileNames);
			mav.setViewName("admin/shop/updateItem");
			return mav;
		}
  
		@RequestMapping("/updateItem.do")
		public ModelAndView updateItem(
				MultipartHttpServletRequest req
				) {
			
			int item_idx = Integer.parseInt(req.getParameter("item_idx"));
			String cate_code = req.getParameter("cate_code");
			String item_name = req.getParameter("item_name");
			String item_info = req.getParameter("item_info");
			int item_price = Integer.parseInt(req.getParameter("item_price"));


			String item_tf = req.getParameter("item_tf").toUpperCase();
			shopitemDTO dto = new shopitemDTO();
			dto.setItem_idx(item_idx);
			dto.setCate_code(cate_code);
			dto.setItem_info(item_info);
			dto.setItem_name(item_name);
			dto.setItem_price(item_price);
			dto.setItem_tf(item_tf.toUpperCase());




			/**======================삭제할 파일 삭제 시작===================================*/
			String[] files = req.getParameterValues("delImg");
			String thumsPath_s = req.getParameter("item_mainimg_s");
			System.out.println(thumsPath_s);
			int post = thumsPath_s.indexOf("/t");
			String thumsPath = thumsPath_s.substring(0, post);

			int last = thumsPath_s.lastIndexOf("/t_");
			String realthum = thumsPath_s.substring(last+3, thumsPath_s.length());

			String fileDir=req.getRealPath("itemImg\\"+thumsPath);
			String thumDir=req.getRealPath("itemImg\\"+thumsPath_s);
			if(files!=null&&files.length>0) {
				for(int i = 0; i < files.length ; i++) {
					File f=new File(fileDir+"/"+files[i]);
					if(f.exists()) {
						if(f.isFile()) {
							f.delete();
							if(f.getName().equals(realthum)) {
								File thumF = new File(thumDir);
								if(thumF.exists()) {
									if(thumF.isFile()) {
										thumF.delete();
									}
								}
							}
						}
					}
				}
			}

			/**==================삭제할 파일 삭제 끝=============================================*/
			
			/**===================================메인 썸네일 수정하기==============================*/
			int thum_tf = Integer.parseInt(req.getParameter("thum_tf"));
			MultipartFile mainImg = req.getFile("item_mainimg");
			if(thum_tf==0&&mainImg!=null) {
				
			
				String saveDBPath = UploadImg.uploadMainImg(mainImg, fileDir, thumsPath);
				
				dto.setItem_mainimg(saveDBPath);
			}else {
				dto.setItem_mainimg(thumsPath_s);
			}
			/**===================================메인 썸네일 수정하기==============================*/
			/**=================================서브이미지 추가하기=========================================*/
			int sub_tf = Integer.parseInt(req.getParameter("subimg_tf"));
			if(sub_tf>0) {

				List<MultipartFile> filesuploads = req.getFiles("item_subimg");
				UploadImg.uploadSubImg(filesuploads, fileDir);
			}	
			/**========================================서브이미지 추가하기 끝==============================*/
			
			int result = shopdao.updateItem(dto);
			String msg = result>0?"등록을 완료했습니다.":"등록에 실패했습니다.";
			ModelAndView mav = new ModelAndView();
			mav.addObject("msg", msg);
			mav.addObject("goPage", "adminPage.do");
			mav.setViewName("admin/shop/msg");
			return mav;
		}
		
		@RequestMapping(value="/itemInfoImgUpload.do")
		@ResponseBody
		public Map<String,Object> productImgUpload(HttpServletRequest req,@RequestParam MultipartFile upload)
		throws Exception
		{
			boolean result;
			int post;
			String ext;
			String fileName;
			String fileUrl;
			String Localpath;
			String uploadPath;
			String[] images;
			String dirName;
				fileName = upload.getOriginalFilename();
				post = fileName.lastIndexOf(".");
				ext = fileName.substring(post + 1).toLowerCase();
				images = new String[]{"jpg", "jpeg", "png", "gif", "bmp"};
				result = false;
				dirName = fileName.substring(0, post);
			Map<String,Object> data= new HashMap<String,Object>();	
		    		//(1) 이미지 양식 검증
		        for (String str : images) {
		            if (str.equals(ext)) {
		                result = true;
		                break;}}
		        
		        if(!result) {
						data.put("uploaded", 0);
						data.put("fileName", fileName);		
						data.put("error", "올바른 형식의 이미지가 아닙니다.");
						
					return data;}

		    
		        try {
					//(2) 서버에 업로드
				
					uploadPath = req.getRealPath("itemCKImg\\item\\"+dirName);
					File f=new File(uploadPath); 
					if(!f.exists()) { 
						f.mkdirs();
				}
					upload.transferTo(new File(uploadPath+"/"+fileName));
					fileUrl = req.getContextPath()+"/itemCKImg/item/"+dirName+"/"+fileName;
					System.out.println(fileUrl);
					data.put("fileName", uploadPath);
					data.put("uploaded", 1);
					data.put("url", fileUrl);		
					
					//(3) WEB 미리보기용 업로드
//					Localpath="C:\\YKprince\\more_shop\\moreshop\\src\\main\\webapp\\itemCKImg";
//				try {
//					FileCopyUtils.copy(upload.getInputStream(), new FileOutputStream(new File(Localpath,fileName)));}
//				catch (IOException e) {e.printStackTrace();}}
//		        catch(IOException e) {e.printStackTrace();}
		}catch (IOException e) {e.printStackTrace();}
			return data;
		}		
//		
//		private String getFolder() {
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//			
//			Date date = new Date(0);
//			
//			String str = sdf.format(date);
//			
//			return str.replace("-", File.separator);
//		}
		
		@RequestMapping("/controllTf")
		@ResponseBody
		public Map<String, String> controllTF(
				@RequestParam(value="item_idx", defaultValue = "1")int item_idx
				,@RequestParam(value="item_tf")String item_tf){
			
			System.out.println(item_idx+"/"+item_tf);
			Map map = new HashMap();
			map.put("item_idx", item_idx);
			map.put("item_tf", item_tf);
			
			int result = shopdao.controllTF(map);
			
			String msg = result>0?(item_tf.equals("T")?"상품을 게시하였습니다.":"상품을 내렸습니다."):"문제가 발생했습니다.";
			
			Map<String, String> resultMap = new HashMap<String, String>();
			resultMap.put("msg", msg);
			return resultMap;
		}
		
		@RequestMapping("/orderManageForm.do")
		public ModelAndView orderManagerForm() throws Exception {


			ModelAndView mav = new ModelAndView();

			mav.setViewName("admin/shop/orderManager");
			return mav;
		}
			
			
		@RequestMapping(value = "/orderManager.do")
		@ResponseBody
		public Map selectOrderList(HttpServletRequest req) throws Exception {
			System.out.println(req.getParameter("search_option"));
			System.out.println(req.getParameter("cp"));
			String keyword = req.getParameter("keyword");
			String search_option = req.getParameter("search_option");
			String sort_option = req.getParameter("sort_option");
			int cp = Integer.parseInt(req.getParameter("cp"));
			System.out.println(sort_option+"///"+search_option+"//"+keyword);
			int listSize = 4;
			int pageSize = 3;
			int start=(cp-1)*listSize+1;
			int end= cp*listSize;
			
			Map map = new HashMap();
			map.put("keyword", keyword);
			map.put("search_option", search_option);
			map.put("sort_option", sort_option);
			map.put("start", start);
			map.put("end", end);

			int totalCnt = aodao.totalCnt(map);

			String paging = more.paging.pagingModule.makePage("orderManager.do", totalCnt, cp, listSize, pageSize);
			System.out.println(paging);
			
			List list = aodao.orderListAdmin(map);

			Map resultMap = new HashMap();
			resultMap.put("list", list);
			resultMap.put("paging", paging);
			return resultMap;
		}
			
		@RequestMapping("/confirmCancel.do")
		@ResponseBody
		public Map orderCancel(@RequestParam("order_idx")int order_idx,@RequestParam("order_state")String order_state) {
			
			Map map = new HashMap();
			map.put("order_state", order_state);
			map.put("order_idx", order_idx);
			int result = aodao.orderUpdate(map);
			String msg = result>0?"요청이 처리되었습니다.":"요청 실패!";

			Map resultMap = new HashMap();
			resultMap.put("msg", msg);
			return resultMap;
		}
		@RequestMapping("/stateUpdateForm.do")
		@ResponseBody
		public Map adminOrderDetail(@RequestParam("order_idx")int order_idx) throws Exception {

			Map map = new HashMap();
			map.put("order_idx", order_idx);
			orderDTO master = aodao.orderMaster(map);
			System.out.println("===="+master.getUser_totalpay());
			List<orderItemDTO> details = aodao.orderDetail(map);
			map.put("master", master);
			map.put("details", details);
			return map;
		}
		@RequestMapping("/stateUpdate.do")
		@ResponseBody
		public Map orderManage(@RequestParam("order_idx")int order_idx,
				@RequestParam("user_email")String user_email,
				@RequestParam("order_state")String order_state,
				@RequestParam("item_idx[]")int[] item_idx,
				@RequestParam("detail_unit[]")int[] detail_unit,
				@RequestParam("item_price[]")int[] item_price
				) throws Exception {

			List<Integer> idxList = new ArrayList<Integer>();
			List<Integer> unitList = new ArrayList<Integer>();
			List<Integer> priceList = new ArrayList<Integer>();
			for(int i=0;i< item_idx.length;i++) {
				idxList.add(item_idx[i]);
				unitList.add(detail_unit[i]);
				priceList.add(item_price[i]);
			}
			Map map = new HashMap();
			map.put("order_idx", order_idx);
			map.put("user_email", user_email);
			map.put("order_state", order_state);
			map.put("idxList", idxList);
			map.put("unitList", unitList);
			map.put("priceList", priceList);
			int result = aodao.orderUpdate(map);
			
			
		//	
			Map<String, String> resultMap = new HashMap<String, String>();
			String msg = result>0?"주문 상태를 변경했습니다.":"문제가 발생했습니다."; 
			map.put("msg", msg);
			
			

			
				EmailDTO emailDto = new EmailDTO();
				emailDto.setSenderName("모어펫");
				emailDto.setSenderMail("kruise1157@gmail.com");
				emailDto.setReceiveMail(user_email);
				emailDto.setSubject("고객님의 주문이 ["+order_state+"] 상태로 업데이트 되었습니다.");
				emailDto.setMessage("테스트임당");
				try {
					emailDao.sendMail(emailDto);
				}catch (Exception e) {
					e.printStackTrace();
				}
				
			int user_idx = aodao.findIdx(user_email);
			map.put("user_idx", user_idx);
			
			
		
			return map;
		}
		
		@RequestMapping("/shopChartForm.do")
		public ModelAndView shopCartForm() {
			
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("admin/shop/shopChart");
			
			Map map = chartdao.totalGraph();
			bestUserChartDTO bestuserdto = (bestUserChartDTO) map.get("bestUser");
			totalChartDTO totalchartdto = (totalChartDTO) map.get("totalChart");
			mav.addObject("budto", bestuserdto);
			mav.addObject("tcdto", totalchartdto);
			return mav;
		}
		
		@RequestMapping("/defaultChartList.do")
		@ResponseBody
		public JSONObject defaultChartList() {
			
			
			List<shopChartDTO> list = chartdao.defaultChart();
			Map resultMap = new HashMap();
			resultMap.put("list", list);
		
			//리턴할 json 객체
			//JSONObject allGraph = new JSONObject();
	        JSONObject data = new JSONObject(); //{}
	        
	        //json의 칼럼 객체
	        JSONObject col1 = new JSONObject();
	        JSONObject col2 = new JSONObject();
			
	        //json 배열 객체, 배열에 저장할때는 JSONArray()를 사용
	        JSONArray title = new JSONArray();
	        col1.put("label","상품명"); //col1에 자료를 저장 ("필드이름","자료형")
	        col1.put("type", "string");
	        col2.put("label", "금액");
	        col2.put("type", "number");
	        
	        //테이블행에 컬럼 추가
	        title.add(col1);
	        title.add(col2);
	        
	        //json 객체에 타이틀행 추가
	        data.put("cols", title);//제이슨을 넘김
	        //이런형식으로 추가 {"cols" : [{"label" : "상품명","type":"string"}
	        //,{"label" : "금액", "type" : "number"}]}
			
	        JSONArray body = new JSONArray(); //json 배열을 사용하기 위해 객체를 생성
	        
	        for (shopChartDTO dto : list) { //items에 저장된 값을 dto로 반복문을 돌려서 하나씩 저장
	            
	            JSONObject name = new JSONObject(); //json오브젝트 객체를 생성
	            name.put("v", dto.getItem_name()); //name변수에 dto에 저장된 상품의 이름을 v라고 저장
	            
	            JSONObject money = new JSONObject(); //json오브젝트 객체를 생성
	            money.put("v", dto.getTotal_incost()); //name변수에 dto에 저장된 금액을 v라고 저장
	            
	            JSONArray row = new JSONArray(); //json 배열 객체 생성 (위에서 저장한 변수를 칼럼에 저장하기위해)
	            row.add(name); //name을 row에 저장 (테이블의 행)
	            row.add(money); //name을 row에 저장 (테이블의 행)
	            
	            JSONObject cell = new JSONObject(); 
	            cell.put("c", row); //cell 2개를 합쳐서 "c"라는 이름으로 추가
	            body.add(cell); //레코드 1개 추가
	                
	        }
	        data.put("rows", body); //data에 body를 저장하고 이름을 rows라고 하기
	       // allGraph.put("data", data);
	        
	        
			return data;
		}
		
		
		@RequestMapping("/periodChart.do")
		@ResponseBody
		public JSONObject peridoChart(HttpServletRequest req) {
			
			int period = Integer.parseInt(req.getParameter("period"));
			List<periodChartDTO> list = chartdao.periodChart();
			list = list.subList(0, period);
			Collections.reverse(list);
			//리턴할 json 객체
			//JSONObject allGraph = new JSONObject();
	        JSONObject data = new JSONObject(); //{}
	        
	        //json의 칼럼 객체
	        JSONObject col1 = new JSONObject();
	        JSONObject col2 = new JSONObject();
			
	        //json 배열 객체, 배열에 저장할때는 JSONArray()를 사용
	        JSONArray title = new JSONArray();
	        col1.put("label","기간"); //col1에 자료를 저장 ("필드이름","자료형")
	        col1.put("type", "string");
	        col2.put("label", "매출");
	        col2.put("type", "number");
	        
	        //테이블행에 컬럼 추가
	        title.add(col1);
	        title.add(col2);
	        
	        data.put("cols", title);//제이슨을 넘김
			
	        JSONArray body = new JSONArray(); 
	        
	        for (periodChartDTO dto : list) { //items에 저장된 값을 dto로 반복문을 돌려서 하나씩 저장
	            
	            JSONObject name = new JSONObject(); //json오브젝트 객체를 생성
	            name.put("v", dto.getPeriod()); //name변수에 dto에 저장된 상품의 이름을 v라고 저장
	            
	            JSONObject money = new JSONObject(); //json오브젝트 객체를 생성
	            money.put("v", dto.getEarn()); //name변수에 dto에 저장된 금액을 v라고 저장
	            
	            JSONArray row = new JSONArray(); //json 배열 객체 생성 (위에서 저장한 변수를 칼럼에 저장하기위해)
	            row.add(name); //name을 row에 저장 (테이블의 행)
	            row.add(money); //name을 row에 저장 (테이블의 행)
	            
	            JSONObject cell = new JSONObject(); 
	            cell.put("c", row); //cell 2개를 합쳐서 "c"라는 이름으로 추가
	            body.add(cell); //레코드 1개 추가
	                
	        }
	        data.put("rows", body); //data에 body를 저장하고 이름을 rows라고 하기
	       // allGraph.put("data", data);
	        
	        
			return data;
		}
		
		
		@RequestMapping("/areaChart.do")
		@ResponseBody
		public JSONObject areaChart() {
			
			List<areaChartDTO> list = chartdao.areaChart();
			//리턴할 json 객체
			//JSONObject allGraph = new JSONObject();
	        JSONObject data = new JSONObject(); //{}
	        
	        //json의 칼럼 객체
	        JSONObject col1 = new JSONObject();
	        JSONObject col2 = new JSONObject();
			
	        //json 배열 객체, 배열에 저장할때는 JSONArray()를 사용
	        JSONArray title = new JSONArray();
	        col1.put("label","지역"); //col1에 자료를 저장 ("필드이름","자료형")
	        col1.put("type", "string");
	        col2.put("label", "매출");
	        col2.put("type", "number");
	       
	        //테이블행에 컬럼 추가
	        title.add(col1);
	        title.add(col2);
	        
	        data.put("cols", title);//제이슨을 넘김
			
	        JSONArray body = new JSONArray(); 
	        
	        for (areaChartDTO dto : list) { //items에 저장된 값을 dto로 반복문을 돌려서 하나씩 저장
	        	
	        	
	        	JSONObject name = new JSONObject(); //json오브젝트 객체를 생성
	        	if(dto.getArea().trim().equals("서울")) {
	            	name.put("v", "KR-11"); //name변수에 dto에 저장된 상품의 이름을 v라고 저장	
	            	name.put("f", "seoul"); //name변수에 dto에 저장된 상품의 이름을 v라고 저장	
	            }else {
	            	name.put("v", "KR-26"); //name변수에 dto에 저장된 상품의 이름을 v라고 저장
	            	name.put("f", "busan"); //name변수에 dto에 저장된 상품의 이름을 v라고 저장
				}
	            
	            
	            JSONObject money = new JSONObject(); //json오브젝트 객체를 생성
	            money.put("v", dto.getTotalpay()); //name변수에 dto에 저장된 금액을 v라고 저장
	            
	            JSONArray row = new JSONArray(); //json 배열 객체 생성 (위에서 저장한 변수를 칼럼에 저장하기위해)
	            row.add(name); //name을 row에 저장 (테이블의 행)
	            row.add(money); //name을 row에 저장 (테이블의 행)
	            
	            JSONObject cell = new JSONObject(); 
	            cell.put("c", row); //cell 2개를 합쳐서 "c"라는 이름으로 추가
	            body.add(cell); //레코드 1개 추가
	                
	        }
	        data.put("rows", body); //data에 body를 저장하고 이름을 rows라고 하기
	       // allGraph.put("data", data);
	        
	    //    JSONArray and = new JSONArray();
	      //  and.add(data);
			return data;
		}
		
		
		@RequestMapping("/stockDetailForm.do")
		public ModelAndView stockDetailForm(@RequestParam(value="item_idx", defaultValue = "1" )int item_idx) throws Exception {


			ModelAndView mav = new ModelAndView();
			mav.addObject("item_idx", item_idx);
			mav.setViewName("admin/shop/stockDetail");
			return mav;
		}

		@RequestMapping("/newChart.do")
		@ResponseBody
		public JSONObject newData(HttpServletRequest req) {
			
			
			List<periodChartDTO> list = chartdao.periodChart();
			//리턴할 json 객체
			//JSONObject allGraph = new JSONObject();
	        JSONObject data = new JSONObject(); //{}
	        
	        //json의 칼럼 객체
	        JSONObject col1 = new JSONObject();
	        JSONObject col2 = new JSONObject();
	        JSONObject col3 = new JSONObject();
	        JSONObject col4 = new JSONObject();
	        			
	        //json 배열 객체, 배열에 저장할때는 JSONArray()를 사용
	        JSONArray title = new JSONArray();
	        col1.put("id","");
	        col1.put("label","날짜");
	        col1.put("pattern", "");
	        col1.put("type", "datetime");
	        
	        col2.put("id","");
	        col2.put("label", "강아지");
	        col2.put("pattern", "");
	        col2.put("type", "number");
	        
	        col3.put("id","");
	        col3.put("label", "고양이");
	        col3.put("pattern", "");
	        col3.put("type", "number");
	        
	        col4.put("id","");
	        col4.put("label", "전체");
	        col4.put("pattern", "");
	        col4.put("type", "number");
	        
	        
	        //테이블행에 컬럼 추가
	        title.add(col1);
	        title.add(col2);
	        title.add(col3);
	        title.add(col4);
	        
	        data.put("cols", title);//제이슨을 넘김
	        
	        JSONArray body = new JSONArray(); //json 배열을 사용하기 위해 객체를 생성
	        
	        for (periodChartDTO dto : list) { //items에 저장된 값을 dto로 반복문을 돌려서 하나씩 저장

	        	JSONObject today = new JSONObject();
	        	String arr[] = dto.getPeriod().split("-");
	            today.put("v", "Date("+arr[0]+","+arr[1]+")"); 
	        	
	            JSONObject dog = new JSONObject();
	            dog.put("v", dto.getDogSales());
	            
	            JSONObject cat = new JSONObject(); 
	            cat.put("v", dto.getCatSales()); 
	            
	            JSONObject all = new JSONObject(); 
	            all.put("v", dto.getTotal()); 
	            
	            JSONArray row = new JSONArray(); //json 배열 객체 생성 (위에서 저장한 변수를 칼럼에 저장하기위해)
	            row.add(today); //name을 row에 저장 (테이블의 행)
	            row.add(dog); //name을 row에 저장 (테이블의 행)
	            row.add(cat); //name을 row에 저장 (테이블의 행)
	            row.add(all); //name을 row에 저장 (테이블의 행)
	            
	            JSONObject cell = new JSONObject(); 
	            cell.put("c", row); //cell 2개를 합쳐서 "c"라는 이름으로 추가
	            body.add(cell); //레코드 1개 추가
	                
	        }
	        data.put("rows", body); //data에 body를 저장하고 이름을 rows라고 하기
	       // allGraph.put("data", data);
	        
	        
			return data;
		}
		
      
         		// 입출고 내역 할지말지 정하기====================
		//오더매니저 ㅇ이템리스트
//		@RequestMapping(value = "/getStockDetailList.do")
//		@ResponseBody
//		public Map getStockDetailList(HttpServletRequest req) throws Exception {
//			
//			int item_idx = Integer.parseInt(req.getParameter("item_idx"));
//			int listSize = 2;
//			int pageSize = 3;
//			int start=(cp-1)*listSize+1;
//			int end= cp*listSize;
//			
//			Map map = new HashMap();
//			map.put("keword", keword);
//			map.put("search_option", search_option);
//			map.put("sort_option", sort_option);
//			map.put("start", start);
//			map.put("end", end);
//
//			int totalCnt = aodao.totalCnt(map);
//
//			String paging = more.paging.pagingModule.makePage("orderManager.do", totalCnt, cp, listSize, pageSize);
//			System.out.println(paging);
//			
//			List list = aodao.orderListAdmin(map);
//
//			Map resultMap = new HashMap();
//			resultMap.put("list", list);
//			resultMap.put("paging", paging);
//			return resultMap;
	//	}
}
