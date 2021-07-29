package more.pet.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PetDAOImple implements PetDAO {
	
	@Autowired
	private SqlSessionTemplate sqlMap;
	
	public int pet_register(PetDTO dto, int user_idx) {
		
		int result = sqlMap.insert("insertPet",dto);
		
		Map<String, Integer> joinParam = new HashMap<String, Integer>();
		joinParam.put("user_idx", user_idx);
		joinParam.put("pet_idx", dto.getPet_idx());
		sqlMap.insert("insertPetJoin", joinParam);
		
		return dto.getPet_idx();
	}
	
	public List<Map<String, String>> pet_list(int user_idx){
		List<Map<String, String>> result = sqlMap.selectList("selectPetList", user_idx);
		return result;
	}
	
	public PetDTO pet_info(String pet_idx) {
		PetDTO dto = sqlMap.selectOne("selectPetInfo", pet_idx);
		return dto;
	}
	
	public int update_pet(PetDTO dto) {
		int result = sqlMap.update("updatePetInfo", dto);
		return result;
	}
	
	public int delete_pet(int pet_idx) {
		int result = sqlMap.delete("deletePet", pet_idx);
		return result;
	}
}
