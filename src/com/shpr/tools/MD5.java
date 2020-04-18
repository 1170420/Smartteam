package com.shpr.tools;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.log4j.Logger;


/***
 * MD5加密
 * @author yandongfa
 *
 */
public class MD5 {
	

	
	private static Logger logger = Logger.getLogger(MD5.class);
	
	public static String Md5(String pwd) throws Exception {
		
		/*byte[] secretBytes = null;
        try {
            secretBytes = MessageDigest.getInstance("md5").digest(
            		pwd.getBytes());
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("没有这个md5算法！");
        }
        String md5code = new BigInteger(1, secretBytes).toString(16);
        for (int i = 0; i < 32 - md5code.length(); i++) {
            md5code = "0" + md5code;
        }
        logger.info("MD5加密后的密码："+md5code);
        return md5code;
	}*/
		try {
            // 得到一个信息摘要器
            MessageDigest digest = MessageDigest.getInstance("md5");
            byte[] result = digest.digest(pwd.getBytes());
            StringBuffer buffer = new StringBuffer();
            // 把每一个byte 做一个与运算 0xff;
            for (byte b : result) {
                // 与运算
                int number = b & 0xff;// 加盐
                String str = Integer.toHexString(number);
                if (str.length() == 1) {
                    buffer.append("0");
                }
                buffer.append(str);
            }
            logger.info("MD5加密后的密码："+buffer.toString());
            // 标准的md5加密后的结果
            return buffer.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return "";
        }


	}
}
