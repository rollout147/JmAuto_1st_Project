package com.oracle.jmAuto.service.jm;

public interface EmailService {

	String sendAuthCode(String user_email);

    int sendTempPw(String user_id, String tempPassword);

	int sendApproveMail(String user_id);


    
}
