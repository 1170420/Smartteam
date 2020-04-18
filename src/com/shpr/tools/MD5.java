package com.shpr.tools;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.log4j.Logger;


/***
 * MD5����
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
            throw new RuntimeException("û�����md5�㷨��");
        }
        String md5code = new BigInteger(1, secretBytes).toString(16);
        for (int i = 0; i < 32 - md5code.length(); i++) {
            md5code = "0" + md5code;
        }
        logger.info("MD5���ܺ�����룺"+md5code);
        return md5code;
	}*/
		try {
            // �õ�һ����ϢժҪ��
            MessageDigest digest = MessageDigest.getInstance("md5");
            byte[] result = digest.digest(pwd.getBytes());
            StringBuffer buffer = new StringBuffer();
            // ��ÿһ��byte ��һ�������� 0xff;
            for (byte b : result) {
                // ������
                int number = b & 0xff;// ����
                String str = Integer.toHexString(number);
                if (str.length() == 1) {
                    buffer.append("0");
                }
                buffer.append(str);
            }
            logger.info("MD5���ܺ�����룺"+buffer.toString());
            // ��׼��md5���ܺ�Ľ��
            return buffer.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return "";
        }


	}
}
