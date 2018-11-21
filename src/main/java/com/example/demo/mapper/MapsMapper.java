package com.example.demo.mapper;
import java.util.List;
import com.example.demo.po.Maps;
public interface MapsMapper {

    public void updatMaps(Maps map) throws Exception;
    public List<String> findMapsByUserid(int userid) throws Exception;
    public String findLayerTreeByMaps(Maps map) throws Exception;

}
