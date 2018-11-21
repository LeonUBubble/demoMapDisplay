package com.example.demo.service;

import java.util.List;
import com.example.demo.po.Maps;
public interface MapsService {
    public String updateMap(Maps map) throws Exception;
    public List<String> findMapByUserid(int userid) throws Exception;
    public String findLayerTreeByMap(Maps map) throws Exception;
}
