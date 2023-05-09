package com.example.library.service;
import com.example.library.domain.Record;
import com.example.library.domain.User;
import entity.PageResult;

/**
 * 预约记录接口
 */
public interface RecordService {
    //新增预约记录
    Integer addRecord(Record record);
//查询预约记录
PageResult searchRecords(Record record, User user, Integer pageNum, Integer pageSize);
}
