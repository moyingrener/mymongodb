package com.myee.pojo;

import org.bson.types.ObjectId;

public class BRFormCustom extends BRForm {
private ObjectId _id;
private String time;

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public ObjectId get_id() {
        return _id;
    }

    public void set_id(ObjectId _id) {
        this._id = _id;
    }
}
