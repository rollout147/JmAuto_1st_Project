package com.oracle.jmAuto.domain;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.bind.ConstructorBinding;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@ConfigurationProperties(prefix = "mail")
public class MailProperties {
    private final String host;
    private final String address;
    private final String personal;
    private final String userName;
    private final String password;
    private final int port;

    @ConstructorBinding
    public MailProperties(String host, String address, String personal, String username, String password, int port) {
        this.host = host;
        this.address = address;
        this.personal = personal;
        this.userName = username;
        this.password = password;
        this.port = port;
    }
}
