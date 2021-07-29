package more.chat.model;

import java.util.*;
public interface chatDAO {

	public int saveMessage(MessageDTO mdto);
	public String roomCheck(MessageDTO mdto);
	public int createRoom(RoomDTO rdto);
	public int insertAlarm(MessageDTO mdto);
	public List getAlarmList(String user_idx);
	public List getRoomList(String user_idx);
	public List getMessageList(String room_idx);
	public Integer roomCheck2(RoomDTO dto);
	public int updateJoinDate(MessageDTO dto);
	public List getRoomMember(MessageDTO dto);
	public int createRooms(RoomDTO dto);
	public int updateJoinDate2(Map map);
}
