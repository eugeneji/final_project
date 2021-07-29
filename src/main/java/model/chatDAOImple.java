package more.chat.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class chatDAOImple implements chatDAO {

	@Autowired
	private SqlSessionTemplate sqlMap;
	
	
	public int updateJoinDate(MessageDTO dto) {
		// TODO Auto-generated method stub
		return sqlMap.update("updateJoinDate", dto);
	}
	
	public int saveMessage(MessageDTO mdto) {
		
		return sqlMap.insert("saveMessage", mdto);
		
	}
	
	public String roomCheck(MessageDTO mdto) {
		return sqlMap.selectOne("roomCheck",mdto);
	}
	
	public int createRoom(RoomDTO rdto) {
		sqlMap.insert("createRoom", rdto);
		return rdto.getRoom_idx();
	}
	
	public int insertAlarm(MessageDTO mdto) {
		
		return sqlMap.insert("insertAlarm", mdto);
	}
	
	public List getAlarmList(String user_idx) {
		// TODO Auto-generated method stub
		return sqlMap.selectList("getAlarmList", user_idx);
	}
	
	public List getRoomList(String user_idx) {
		// TODO Auto-generated method stub
		return sqlMap.selectList("getRoomList", user_idx);
	}
	
	public List getMessageList(String room_idx) {
		// TODO Auto-generated method stub
		return sqlMap.selectList("getMessageList", room_idx);
	}
	
	
	public Integer roomCheck2(RoomDTO dto) {
		
		return sqlMap.selectOne("roomCheck2", dto);
	}
	
	public List getRoomMember(MessageDTO dto) {
		// TODO Auto-generated method stub
		return sqlMap.selectList("getRoomMember", dto);
	}
	
	public int createRooms(RoomDTO dto) {
		
		return sqlMap.insert("createRooms", dto);
	}
	
	public int updateJoinDate2(Map map) {
		// TODO Auto-generated method stub
		return sqlMap.update("updateJoinDate2", map);
	}
}
