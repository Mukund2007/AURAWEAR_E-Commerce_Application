package com.aurawear.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.aurawear.model.UserProfile;
import com.aurawear.util.DBConnection;
import java.sql.ResultSet;
import com.aurawear.model.User;

public class UserDAO {

public boolean registerUser(User user){

try{

Connection con =
DBConnection.getConnection();

String sql=
"INSERT INTO users(name,email,password) VALUES(?,?,?)";

PreparedStatement ps=
con.prepareStatement(sql);

ps.setString(1,user.getName());
ps.setString(2,user.getEmail());
ps.setString(3,com.aurawear.util.PasswordUtil.hashPassword(user.getPassword()));

int rows=ps.executeUpdate();

return rows>0;

}
catch(Exception e){
e.printStackTrace();
}

return false;

}
public boolean emailExists(String email){

try{

Connection con =
DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(
"SELECT * FROM users WHERE email=?"
);

ps.setString(1,email);

ResultSet rs =
ps.executeQuery();

return rs.next();

}
catch(Exception e){
e.printStackTrace();
}

return false;
}
public boolean saveProfile(UserProfile p){

try{

Connection con=
DBConnection.getConnection();

PreparedStatement ps=
con.prepareStatement(
"INSERT INTO user_profiles(user_id,username,style_preference,clothing_size,fit_preference,interests) VALUES(?,?,?,?,?,?)"
);

ps.setInt(1,p.getUserId());
ps.setString(2,p.getUsername());
ps.setString(3,p.getStyle());
ps.setString(4,p.getSize());
ps.setString(5,p.getFit());
ps.setString(6,p.getInterests());

return ps.executeUpdate()>0;

}catch(Exception e){
e.printStackTrace();
}

return false;
}
public User getUserByEmail(String email){

try{

Connection con=
DBConnection.getConnection();

PreparedStatement ps=
con.prepareStatement(
"SELECT * FROM users WHERE email=?"
);

ps.setString(1,email);

ResultSet rs=
ps.executeQuery();

if(rs.next()){

User user =
new User(
rs.getString("name"),
rs.getString("email"),
rs.getString("password")
);

user.setId(
rs.getInt("id")
);

return user;
}

}catch(Exception e){
e.printStackTrace();
}

return null;

}

}