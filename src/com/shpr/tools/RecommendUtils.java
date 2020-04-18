package com.shpr.tools;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import com.shpr.pojo.Content;
import com.shpr.pojo.ShoppingActive;
import com.shpr.pojo.ShoppingUserSimilarity;
/**
 * ��������������Ʒ�Ƽ��Ĺ�����
 * �����ƣ�com.lyu.shopping.recommendate.util.RecommendUtils
 * @author ������
 * 2018��3��25��.����8:10:41
 * @version V1.0
 */
public class RecommendUtils {
    /**
     * �����û��Ĺ�����Ϊ�����ղ������ݿ���
     * @param userId �û�id
     * @param itemId ��Ʒid
     * @return true����³ɹ���false�����ʧ��
     */
    public static boolean updateBuyingBehavior(Long userId, Long itemId) {
        boolean flag = false;
        // TODO
        return flag;
    }
    /**
     * ���û��Ĺ�����Ϊ��װ��һ��map,keyΪuserId��valueҲ��һ��map�����map��¼���Ƕ�����Ŀ�Լ�����Ӧ�ĵ����
     * @param userActiveList �û��Ĺ�����Ϊ�б�
     * @return ��װ�õ��û��Ĺ�����Ϊ��map����
     */
    public static ConcurrentHashMap<Long, ConcurrentHashMap<Long, Long>> assembleUserBehavior(List<ShoppingActive> userActiveList) {
    	
        ConcurrentHashMap<Long, ConcurrentHashMap<Long, Long>> activeMap = new ConcurrentHashMap<Long, ConcurrentHashMap<Long, Long>>();
        // ������ѯ�����û������Ϊ����
        for (ShoppingActive userActive : userActiveList) {
            // 1.��ȡ�û�id
            Long userId = userActive.getUser_id();
            // 2.��ȡ������Ŀid
            Long category2Id = userActive.getCategory2_id();
            // 3.��ȡ�ö�����Ŀ�ĵ����
            Long hits = userActive.getPreviewTotal();
            // �ж�activeMap���Ƿ��Ѿ������˸�userId����Ϣ�������������и���
            if (activeMap.containsKey(userId)) {
                ConcurrentHashMap<Long, Long> tempMap = activeMap.get(userId);
                tempMap.put(category2Id, hits);
                activeMap.put(userId, tempMap);
            } else {
                // ��������ֱ��put��
                ConcurrentHashMap<Long, Long> category2Map = new ConcurrentHashMap<Long, Long>();
                category2Map.put(category2Id, hits);
                activeMap.put(userId, category2Map);
            }
        }
        return activeMap;
    }
    /**
     * �����û����û�֮��������ԣ����ؼ�������û����û�֮������ƶȶ���
     * @param activeMap �û��Ը���������Ŀ�Ĺ�����Ϊ��һ��map����
     * @return ��������û����û�֮������ƶȵĶ���洢��ʽ
     */
    public static List<ShoppingUserSimilarity> calcSimilarityBetweenUsers(ConcurrentHashMap<Long, ConcurrentHashMap<Long, Long>> activeMap) {
        // �û�֮������ƶȶԼ���
        List<ShoppingUserSimilarity> similarityList = new ArrayList<ShoppingUserSimilarity>();
        // ��ȡ���еļ��ļ���
        Set<Long> userSet = activeMap.keySet();
        // ����Щ���Ϸ���ArrayList��
        List<Long> userIdList = new ArrayList<Long>(userSet);
        // С������˵����ǰmap������ֻ��һ��map���ϵĹ�����Ϊ������һ����û�У�ֱ�ӷ���
        if (userIdList.size() < 2) {
            return similarityList;
        }
        // �������е��û�֮������ƶȶ�
        for (int i = 0; i < userIdList.size() - 1; i++) {
            for (int j = i + 1; j < userIdList.size(); j++) {
                // �ֱ��ȡ�����û���ÿ��������Ŀ�ĵ����
                ConcurrentHashMap<Long, Long> userCategory2Map = activeMap.get(userIdList.get(i));
                System.out.println(userCategory2Map);
                //��ȡ��һ���û���ÿ��������Ŀ�ĵ����
                ConcurrentHashMap<Long, Long> userRefCategory2Map = activeMap.get(userIdList.get(j));
                // ��ȡ����map�ж�����Ŀid�ļ���
                Set<Long> key1Set = userCategory2Map.keySet();
                Set<Long> key2Set = userRefCategory2Map.keySet();
                Iterator<Long> it1 = key1Set.iterator();
                Iterator<Long> it2 = key2Set.iterator();
                // ���û�֮������ƶ�
                double similarity = 0.0;
                // �������ƶȹ�ʽ�еķ���
                double molecule = 0.0;
                // �������ƶȹ�ʽ�еķ�ĸ
                double denominator = 1.0;
                // �������ƶȹ�ʽ�з�ĸ�����µ�����������ģ��ֵ
                double vector1 = 0.0;
                double vector2 = 0.0;
                while (it1.hasNext() && it2.hasNext()) {
                    Long it1Id = it1.next();
                    Long it2Id = it2.next();
                    // ��ȡ������Ŀ��Ӧ�ĵ������
                    Long hits1 = userCategory2Map.get(it1Id);
                    Long hits2 = userRefCategory2Map.get(it2Id);
                    // �ۼӷ���
                    molecule += hits1 * hits2;
                    // �ۼӷ�ĸ�е�����������ģ
                    vector1 += Math.pow(hits1, 2);
                    vector2 += Math.pow(hits2, 2);
                }
                // �����ĸ
                denominator = Math.sqrt(vector1) * Math.sqrt(vector2);
                // �����������ƶ�
                similarity = molecule / denominator;
                // �����û����ƶȶԶ���
                ShoppingUserSimilarity userSimilarityDTO = new ShoppingUserSimilarity();
                userSimilarityDTO.setUser_id(userIdList.get(i));
                userSimilarityDTO.setUser_ref_id(userIdList.get(j));
                userSimilarityDTO.setSimilarty(similarity);
                
                // ����������û��Լ��û�֮������ƶȶ������list����
                similarityList.add(userSimilarityDTO);
            }
        }
        return similarityList;
    }
    /**
     * �ҳ���userId������Ϊ�����Ƶ�topN���û�
     * @param userId ��Ҫ�ο����û�id
     * @param userSimilarityDTO �û����ƶ��б�
     * @param topN ��userId�����û�������
     * @return ��usereId�����Ƶ�topN���û�
     */
    public static List<Long> getSimilarityBetweenUsers(Long userId, List<ShoppingUserSimilarity> userSimilarityDTOList, Integer topN) {
        // ������¼��userId���ƶ���ߵ�ǰN���û���id
        List<Long> similarityList = new ArrayList<Long>(topN);
        // �������ҳ���ߵ�ǰN���û�������С���ѣ�������ʱ��ǰ��������ƶȱȶѶ�Ԫ�ش���޵��Ѷ���ֵ������������(��С�Ķ�ɾ���ɾ�,����Ҫ����С����)
        PriorityQueue<ShoppingUserSimilarity> minHeap = new PriorityQueue<ShoppingUserSimilarity>(new Comparator<ShoppingUserSimilarity>(){
            @Override
            public int compare(ShoppingUserSimilarity o1, ShoppingUserSimilarity o2) {
                if (o1.getSimilarty() - o2.getSimilarty() > 0) {
                    return 1;
                } else if (o1.getSimilarty() - o2.getSimilarty() == 0) {
                    return 0;
                } else {
                    return -1;
                }
            }
        });
        System.out.println("����===�������ƶȵ��û���id=="+minHeap);
        for (ShoppingUserSimilarity userSimilarityDTO : userSimilarityDTOList) {
            if (minHeap.size() < topN) {
                minHeap.offer(userSimilarityDTO);
            } else if (minHeap.peek().getSimilarty() < userSimilarityDTO.getSimilarty()) {
                minHeap.poll();
                minHeap.offer(userSimilarityDTO);
            }
        }
        System.out.println("����===�������ƶȵ��û���id=="+minHeap);
        // �ѵõ����������ƶȵ��û���idȡ����(��Ҫȡ���Լ�)
        for (ShoppingUserSimilarity userSimilarityDTO : minHeap) {
            similarityList.add(userSimilarityDTO.getUser_id() == userId ? userSimilarityDTO.getUser_ref_id() : userSimilarityDTO.getUser_id());
        }
        System.out.println("����====����list=="+similarityList);
        return similarityList;
    }
    /**
     * ��similarUserList�е��û����ʵĶ�����Ŀ�в���userId����������Ķ�����Ŀ�л�ñ��Ƽ�����Ŀid
     * @param userId ���Ƽ���Ʒ���û�id
     * @param similarUserList ��userId���Ƶ��û�����
     * @param userActiveList �����û��������Ϊ
     * @return �����Ƽ���userId�Ķ�����Ŀid�б�
     */
    public static List<Long> getRecommendateCategory2(Long userId, List<Long> similarUserList, List<ShoppingActive> userActiveList) {
        List<Long> recommeddateShoppingProductList = new ArrayList<Long>();
        // userId�������Ϊ�б�
        List<ShoppingActive> userIdActiveList = findUsersBrowsBehavior(userId, userActiveList);
        System.out.println("����==userId�������Ϊ�б�=="+userIdActiveList);
        // ��userId�������Ϊ���ն�����Ŀid�Ÿ��򣬷���������Ƽ����û��������Ϊ�еĶ�����Ŀ�ĵ������ֱ�����������ʱ�临�Ӷ�ΪO(n2)
        Collections.sort(userIdActiveList, new Comparator<ShoppingActive>(){
            @Override
            public int compare(ShoppingActive o1, ShoppingActive o2) {
                return o1.getCategory2_id().compareTo(o2.getCategory2_id());
            }
        });
        System.out.println("����==userIdActiveList������="+userIdActiveList);
        System.out.println("����similarUserLis="+similarUserList);
        // 1.����useId�����Ϊ���Ƶ�ÿ���û����ҳ�һ���Ƽ��Ķ�����Ŀ
        for (Long refId : similarUserList) {
            // ���㵱ǰ�û�������Ķ�����Ŀ�����뱻�Ƽ����û�������Ķ�����Ŀ�Ĵ����Ĳ�ֵ
            // �ҵ���ǰ����û��������Ϊ
            List<ShoppingActive> currActiveList = findUsersBrowsBehavior(refId, userActiveList);
            System.out.println("����==userId�������Ϊ�б�=="+userIdActiveList);
            // ����ͬ��������
            Collections.sort(currActiveList, new Comparator<ShoppingActive>(){
                @Override
                public int compare(ShoppingActive o1, ShoppingActive o2) {
                    return o1.getCategory2_id().compareTo(o2.getCategory2_id());
                }
            });
            System.out.println("����==������"+currActiveList);
            System.out.println("����==�����С"+currActiveList.size());
            // ��¼��ֵ���Ķ�����Ŀ��id
            long maxCategory2 = 0L;
            // ��¼���Ĳ�ֵ
            double maxDifference = 0.0;
            for (int i = 0; i < currActiveList.size(); i++) {
                // ����������ֵ���Ķ�����Ŀ����ΪҪ�Ƽ�����Ŀ
                double difference = Math.abs(currActiveList.get(i).getPreviewTotal() - userIdActiveList.get(i).getPreviewTotal());
                System.out.println("����==�������ֵ"+difference);
                if (difference > maxDifference) {
                    maxDifference = difference;
                    maxCategory2 = currActiveList.get(i).getCategory2_id();
                    System.out.println("����==maxCategory2=="+maxCategory2);
                }
            }
            recommeddateShoppingProductList.add(maxCategory2);
            System.out.println("����==�Ƽ���userId�Ķ�����Ŀid�б�=="+recommeddateShoppingProductList);
        }
        return recommeddateShoppingProductList;
    }
    /**
     * �ҵ���ǰ�û��������Ϊ�б�
     * @param userId ��ǰ�û�id
     * @param userActiveList �����û��������Ϊ�б�
     * @return ��ǰ�û��������Ϊ�б�
     */
    public static List<ShoppingActive> findUsersBrowsBehavior(Long userId, List<ShoppingActive> userActiveList) {
        List<ShoppingActive> currActiveList = new ArrayList<ShoppingActive>();
        for (ShoppingActive userActiveDTO : userActiveList) {
            if (userActiveDTO.getUser_id().equals(userId)) {
                currActiveList.add(userActiveDTO);
            }
        }
        return currActiveList;
    }
    /**
     * �ҵ���ǰ��Ʒ�б��е������ߵ���Ʒ
     * @param productList ��Ʒ�б�
     * @return �������ߵ���Ʒ
     */
    public static Content findMaxHitsContent(List<? extends Content> contentList) {
        if (contentList == null || contentList.size() == 0) {
            return null;
        }
        // ��¼��ǰ���ĵ����
        long maxHits = 0L;
        // ��¼��ǰ�����������Ʒ
        Content product = null;
        for (Content temp : contentList) {
            if (temp.getOnclick() >= maxHits) {
                maxHits = temp.getOnclick(); 
                product = temp;
            }
        }
        return product;
    }
	
}