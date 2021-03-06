package com.shpr.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shpr.pojo.Feedback;
import com.shpr.pojo.Log;
import com.shpr.pojo.User;
import com.shpr.pojo.onecategory;
import com.shpr.pojo.towcategory;

public interface UserDao {

public User selecetUserByIdLogin(@Param("user_name")String user_name, @Param("user_pwd")String user_pwd);

public List<User>getUserList();

public int deleteUserInfo(User user);

public int stopUser(User user);

public int starUser(User user);

public int updateUserInfo(User user);

public void saveLogInformation(Log logs);

public int saveUserInfo(User user);

public int selectUserExist(String user_name);

public User selectUserById(int id);

public List<Log> getLogList();

public void deleteLogs(int[] ids);

public int selectUserExist1(String teach_name);

public int updateUserPwd(User user);

public int saveUserFeedback(Feedback feed);

public List<User> getinformation();

public List<onecategory> getonecategoryList();

public int saveonecateInfo(onecategory onecate);

public int updateonecateInfo(onecategory onecate);

public int deleteOnecate(onecategory onecate);

public List<onecategory> ShowOnecate();

public List<towcategory> gettowcategoryList();

public int savetowcateInfo(towcategory towcate);

public int updateTowcateInfo(towcategory towcate);

public int deleteTowcate(towcategory towcate);

public List<Feedback> getUserfeedList();



}
