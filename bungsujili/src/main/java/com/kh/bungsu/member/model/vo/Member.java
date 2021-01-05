package com.kh.bungsu.member.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Member implements Serializable {

	private String memberId;
	private String password;
	private String nickname;
	private String phone;
	private String reg_date;
	private String business_no;
	private char quit_yn;
	
}
