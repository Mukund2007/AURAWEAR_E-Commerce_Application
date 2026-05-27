package com.aurawear.model;

public class UserProfile {

private int userId;
private String username;
private String style;
private String size;
private String fit;
private String interests;

public UserProfile(
int userId,
String username,
String style,
String size,
String fit,
String interests
){
this.userId=userId;
this.username=username;
this.style=style;
this.size=size;
this.fit=fit;
this.interests=interests;
}

public int getUserId(){
return userId;
}

public String getUsername(){
return username;
}

public String getStyle(){
return style;
}

public String getSize(){
return size;
}

public String getFit(){
return fit;
}

public String getInterests(){
return interests;
}

}