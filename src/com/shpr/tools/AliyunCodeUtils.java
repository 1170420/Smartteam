package com.shpr.tools;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.QuerySendDetailsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.QuerySendDetailsResponse;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * @time  2019/8/22
 * @author yandongfa
 * @category ������ʶ�����֤�����ӿ�
 *
 */
public class AliyunCodeUtils {
   //��Ʒ����:��ͨ�Ŷ���API��Ʒ,�����������滻
   static final String product = "Dysmsapi";
   //��Ʒ����,�����������滻
   static final String domain = "dysmsapi.aliyuncs.com";

   //����˴���Ҫ�滻�ɿ������Լ���AK(�ڰ����Ʒ��ʿ���̨Ѱ��)
   static final String accessKeyId = "LTAIgUMi1Ol3AyZa";
   static final String accessKeySecret = "rid0eNqbyFXMKSj2Ul23RkJGfnnCH9";
   //�������ǩ��,�滻�ɿ������Լ�����Ķ���ǩ��
   static final String signName = "���������Ƽ����ƽ̨";
   //�������ģ�壬�滻�ɿ������Լ������ģ��CODE
   static final String identityTemplateCode = "SMS_172881963";

   // ���������֤��(��λ��)
   static int identifyingCode;
   
   //����������ã�ÿ�����������λ����
   public static int getIdentifyingCode(){
      return identifyingCode = new Random().nextInt(900000)+100000;  
   }

   //������֤��
   public static SendSmsResponse sendSms(String phoneNumber, String templateCode, String templateParam) throws ClientException {

       //������������ʱʱ��
       System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
       System.setProperty("sun.net.client.defaultReadTimeout", "10000");

       //��ʼ��acsClient,�ݲ�֧��region��
       IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, accessKeySecret);
       DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
       IAcsClient acsClient = new DefaultAcsClient(profile);

       //��װ�������-��������������̨-�ĵ���������
       SendSmsRequest request = new SendSmsRequest();
       
       //����:�������ֻ���
       //request.setPhoneNumbers("17785947474");
       
       request.setPhoneNumbers(phoneNumber);
       
       //����:����ǩ��-���ڶ��ſ���̨���ҵ�
       //request.setSignName("����ͨϵͳ");
       
       request.setSignName(signName);
       
       //����:����ģ��-���ڶ��ſ���̨���ҵ�
       // request.setTemplateCode("SMS_172738244");
       
       request.setTemplateCode(templateCode);
       
       //��ѡ:ģ���еı����滻JSON��,��ģ������Ϊ"�װ���${name},������֤��Ϊ${code}"ʱ,�˴���ֵΪ
       //request.setTemplateParam("{\"name\":\"Tom\", \"code\":\"123\"}");
       request.setTemplateParam(templateParam);
       
       //ѡ��-���ж�����չ��(�����������û�����Դ��ֶ�)
       //request.setSmsUpExtendCode("90997");

       //��ѡ:outIdΪ�ṩ��ҵ����չ�ֶ�,�����ڶ��Ż�ִ��Ϣ�н���ֵ���ظ�������
       request.setOutId("yourOutId");

       //hint �˴����ܻ��׳��쳣��ע��catch
       SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);

       return sendSmsResponse;
   }

   
   public static QuerySendDetailsResponse querySendDetails(String bizId,String phoneNumber) throws ClientException {

       //������������ʱʱ��
       System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
       System.setProperty("sun.net.client.defaultReadTimeout", "10000");

       //��ʼ��acsClient,�ݲ�֧��region��
       IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, accessKeySecret);
       DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
       IAcsClient acsClient = new DefaultAcsClient(profile);

       //��װ�������
       QuerySendDetailsRequest request = new QuerySendDetailsRequest();
       //����-����
       request.setPhoneNumber(phoneNumber);
       //��ѡ-��ˮ��
       request.setBizId(bizId);
       //����-�������� ֧��30���ڼ�¼��ѯ����ʽyyyyMMdd
       SimpleDateFormat ft = new SimpleDateFormat("yyyyMMdd");
       request.setSendDate(ft.format(new Date()));
       //����-ҳ��С
       request.setPageSize(10L);
       //����-��ǰҳ���1��ʼ����
       request.setCurrentPage(1L);

       //hint �˴����ܻ��׳��쳣��ע��catch
       QuerySendDetailsResponse querySendDetailsResponse = acsClient.getAcsResponse(request);

       return querySendDetailsResponse;
   }
   

   /**
    * ������֤����ţ�templateParam ����ģ����Ҫ����Ĳ�������json��ʽƴ�ӣ�
    * @param phoneNumber
    * @throws ClientException
    * @throws InterruptedException
    */
   public static SendSmsResponse sendIdentifyingCode(String phoneNumber,int identifyingCode) throws ClientException {
       String templateParam = "{\"code\":\"" + identifyingCode + "\"}";
       return sendSms(phoneNumber,identityTemplateCode,templateParam);
   }
   

   public static void main(String[] args) throws ClientException, InterruptedException {
        
       //������
       SendSmsResponse response = sendSms(args[0],identityTemplateCode,"{\"code\":\"" + getIdentifyingCode() + "\"}");
       System.out.println("���Žӿڷ��ص�����----------------");
       System.out.println("Code=" + response.getCode());
       System.out.println("Message=" + response.getMessage());
       System.out.println("RequestId=" + response.getRequestId());
       System.out.println("BizId=" + response.getBizId());
       Thread.sleep(3000L);

       //����ϸ
       if(response.getCode() != null && response.getCode().equals("OK")) {
           QuerySendDetailsResponse querySendDetailsResponse = querySendDetails(response.getBizId(),"***");
           System.out.println("������ϸ��ѯ�ӿڷ�������----------------");
           System.out.println("Code=" + querySendDetailsResponse.getCode());
           System.out.println("Message=" + querySendDetailsResponse.getMessage());
           int i = 0;
           for(QuerySendDetailsResponse.SmsSendDetailDTO smsSendDetailDTO : querySendDetailsResponse.getSmsSendDetailDTOs())
           {
               System.out.println("SmsSendDetailDTO["+i+"]:");
               System.out.println("Content=" + smsSendDetailDTO.getContent());
               System.out.println("ErrCode=" + smsSendDetailDTO.getErrCode());
               System.out.println("OutId=" + smsSendDetailDTO.getOutId());
               System.out.println("PhoneNum=" + smsSendDetailDTO.getPhoneNum());
               System.out.println("ReceiveDate=" + smsSendDetailDTO.getReceiveDate());
               System.out.println("SendDate=" + smsSendDetailDTO.getSendDate());
               System.out.println("SendStatus=" + smsSendDetailDTO.getSendStatus());
               System.out.println("Template=" + smsSendDetailDTO.getTemplateCode());
           }
           System.out.println("TotalCount=" + querySendDetailsResponse.getTotalCount());
           System.out.println("RequestId=" + querySendDetailsResponse.getRequestId());
       }

   }
   

}
