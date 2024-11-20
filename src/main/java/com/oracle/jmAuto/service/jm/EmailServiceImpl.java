package com.oracle.jmAuto.service.jm;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.oracle.jmAuto.dao.jm.JmDao;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {
    private final JavaMailSender mailSender;
    private final JmDao jd;
    
    @Override
    public String sendAuthCode(String user_email) {
        String setFrom = "fantamasitta@gmail.com";
        String title = "JmAuto 인증번호";
        String authCode = String.valueOf((int) (Math.random() * 900000) + 100000);

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
            messageHelper.setFrom(setFrom);
            messageHelper.setTo(user_email);
            messageHelper.setSubject(title);
            messageHelper.setText("인증번호는 " + authCode + " 입니다.");

            mailSender.send(message);
            return authCode; // 인증번호를 반환
        } catch (Exception e) {
            e.printStackTrace(); // 에러 로그 출력
            throw new RuntimeException("이메일 전송 실패", e);
        }
    }


    @Override
    public int sendTempPw(String user_id, String tempPassword) {
    	System.out.println("EmailServiceImpl.sendTempPw start....");

    	String user_email = jd.getUserEmail(user_id);

    	SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("fantamasitta@gmail.com");
    	message.setTo(user_email);
    	message.setSubject("Jm Auto 임시 비밀번호 발급");
    	message.setText("귀하의 임시 비밀번호는 " + tempPassword);
    	
    	
    	int result = 0;
        
        try {
            mailSender.send(message); // 이메일 전송
            System.out.println("임시 비밀번호가 발송되었습니다.");
            result = 1;
            
        } catch (Exception e) {
            System.err.println("이메일 전송 실패: " + e.getMessage());
            // 추가적인 오류 처리 로직
            result = 0;
        }
        return result;
    	
    }


	@Override
	public int sendApproveMail(String user_id) {
		System.out.println("EmailServiceImpl.sendApproveMail start....");
		String user_email = jd.getUserEmail(user_id);
		
		SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("fantamasitta@gmail.com");
    	message.setTo(user_email);
    	message.setSubject("Jm Auto 가입 승인 여부");
    	message.setText("회원님의 가입이 승인되었습니다");
    	
    	
    	int result = 0;
        
        try {
            mailSender.send(message); // 이메일 전송
            System.out.println("승인여부 이메일 전송이 성공되었습니다");
            result = 1;
            
        } catch (Exception e) {
            System.err.println("이메일 전송 실패: " + e.getMessage());
            // 추가적인 오류 처리 로직
            result = 0;
        }
        return result;
	}
}
