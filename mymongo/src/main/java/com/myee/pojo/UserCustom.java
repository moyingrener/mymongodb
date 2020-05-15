package com.myee.pojo;

import org.bson.types.ObjectId;

public class UserCustom extends  User{
    private ObjectId _id;

    public ObjectId get_id() {
        return _id;
    }

    public void set_id(ObjectId _id) {
        this._id = _id;
    }
}
