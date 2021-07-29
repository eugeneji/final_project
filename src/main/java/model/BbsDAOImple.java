package more.bbs.model;

import java.util.*;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BbsDAOImple implements BbsDAO {
   
   @Autowired
   private SqlSessionTemplate sqlMap;
   
   public SqlSessionTemplate getSqlMap() {
      return sqlMap;
   }
   public void setSqlMap(SqlSessionTemplate sqlMap) {
      this.sqlMap = sqlMap;
   }
   
   public int reportBbsWrite(BbsDTO dto) {
      int count=sqlMap.insert("reportBbsWrite", dto);
      return count;
   }
   public List reportBbsList(int cp, int ls) {
      int start=(cp-1)*ls+1;
      int end=cp*ls;
      Map map= new HashMap();
      map.put("start", start);
      map.put("end", end);
      map.put("bbs_category",5);
      List list=sqlMap.selectList("reportBbsList", map);
   
      return list;
   }
   
   public BbsDTO reportBbsContent(int bbs_idx) {
      BbsDTO dto = sqlMap.selectOne("reportBbsContent", bbs_idx);
      return dto;
   }
   
   public int reportBbsEdit(BbsDTO dto) {
     int count=sqlMap.update("reportBbsEdit",dto);
     return count;
   }
   
   public int reportBbsDel(int bbs_idx) {
      int count=sqlMap.delete("reportBbsDel",bbs_idx );
      if(count==1) {
         return count;
      }else if(count==-1) {      
      
      }
      return -1;
   }
   
   public int getTotalCnt(int bbs_category) {
      int count = sqlMap.selectOne("bbsTotalCnt", bbs_category);
      return count==0?1:count;
   }
   //분양,입양
   public List raiseBbsList(int cp, int ls) {
      
      int start=(cp-1)*ls+1;
      int end=cp*ls;
      Map map= new HashMap();
      map.put("start", start);
      map.put("end", end);
      map.put("bbs_category",1);
      List list=sqlMap.selectList("reportBbsList", map);
   
      return list;
      
      //찾기
      
   }
   public List findBbsList(int cp, int ls) {
      int start=(cp-1)*ls+1;
      int end=cp*ls;
      Map map= new HashMap();
      map.put("start", start);
      map.put("end", end);
      map.put("bbs_category",3);
      List list=sqlMap.selectList("findBbsList", map);
   
      return list;
   }
   
   public int findBbsWrite(BbsDTO dto) {
      int count=sqlMap.insert("findBbsWrite", dto);
      return count;
   }
   
   public BbsDTO findBbsContent(int bbs_idx) {
      BbsDTO dto = sqlMap.selectOne("findBbsContent", bbs_idx);
      return dto;
   }
   
   public int findBbsEdit(BbsDTO dto) {
      int count=sqlMap.update("findBbsEdit", dto);
      return count;
   }
   
   public int findBbsDel(int bbs_idx) {
      int count=sqlMap.delete("findBbsDel",bbs_idx );
      if(count==1) {
         return count;
      }else if(count==-1) {      
      
      }
      return -1;
   }
   
   public int reportBbsReadnum(int bbs_idx) {
      int count =sqlMap.update("reportBbsReadnum", bbs_idx);
      return count;
   }
      public int findBbsReadnum(int bbs_idx) {
         int count =sqlMap.update("findBbsReadnum", bbs_idx);
         return count;
   }
   
      public List reportReBbsList(int bbs_idx) {
  		int idx=bbs_idx;
  		Map map = new HashMap();
  		map.put("idx", idx);
  		List list=sqlMap.selectList("reportReBbsList",map);
  		return list;
  	}
}