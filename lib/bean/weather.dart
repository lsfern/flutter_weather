class Weather {
  String cityid;
  String city;
  String cityEn;
  String country;
  String countryEn;
  String updateTime;
  List<Data> data;
  Aqi aqi;

  Weather(
      {this.cityid,
        this.city,
        this.cityEn,
        this.country,
        this.countryEn,
        this.updateTime,
        this.data,
        this.aqi});

  Weather.fromJson(Map<String, dynamic> json) {
    cityid = json['cityid'];
    city = json['city'];
    cityEn = json['cityEn'];
    country = json['country'];
    countryEn = json['countryEn'];
    updateTime = json['update_time'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    aqi = json['aqi'] != null ? new Aqi.fromJson(json['aqi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityid'] = this.cityid;
    data['city'] = this.city;
    data['cityEn'] = this.cityEn;
    data['country'] = this.country;
    data['countryEn'] = this.countryEn;
    data['update_time'] = this.updateTime;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.aqi != null) {
      data['aqi'] = this.aqi.toJson();
    }
    return data;
  }
}

class Data {
  String day;
  String date;
  String week;
  String wea;
  String weaImg;
  String weaDay;
  String weaDayImg;
  String weaNight;
  String weaNightImg;
  String tem;
  String tem1;
  String tem2;
  String humidity;
  String visibility;
  String pressure;
  List<String> win;
  String winSpeed;
  String winMeter;
  String sunrise;
  String sunset;
  String air;
  String airLevel;
  String airTips;
  Alarm alarm;
  List<Hours> hours;
  List<Index> index;

  Data(
      {this.day,
        this.date,
        this.week,
        this.wea,
        this.weaImg,
        this.weaDay,
        this.weaDayImg,
        this.weaNight,
        this.weaNightImg,
        this.tem,
        this.tem1,
        this.tem2,
        this.humidity,
        this.visibility,
        this.pressure,
        this.win,
        this.winSpeed,
        this.winMeter,
        this.sunrise,
        this.sunset,
        this.air,
        this.airLevel,
        this.airTips,
        this.alarm,
        this.hours,
        this.index});

  Data.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    date = json['date'];
    week = json['week'];
    wea = json['wea'];
    weaImg = json['wea_img'];
    weaDay = json['wea_day'];
    weaDayImg = json['wea_day_img'];
    weaNight = json['wea_night'];
    weaNightImg = json['wea_night_img'];
    tem = json['tem'];
    tem1 = json['tem1'];
    tem2 = json['tem2'];
    humidity = json['humidity'];
    visibility = json['visibility'];
    pressure = json['pressure'];
    win = json['win'].cast<String>();
    winSpeed = json['win_speed'];
    winMeter = json['win_meter'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    air = json['air'];
    airLevel = json['air_level'];
    airTips = json['air_tips'];
    alarm = json['alarm'] != null ? new Alarm.fromJson(json['alarm']) : null;
    if (json['hours'] != null) {
      hours = new List<Hours>();
      json['hours'].forEach((v) {
        hours.add(new Hours.fromJson(v));
      });
    }
    if (json['index'] != null) {
      index = new List<Index>();
      json['index'].forEach((v) {
        index.add(new Index.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['date'] = this.date;
    data['week'] = this.week;
    data['wea'] = this.wea;
    data['wea_img'] = this.weaImg;
    data['wea_day'] = this.weaDay;
    data['wea_day_img'] = this.weaDayImg;
    data['wea_night'] = this.weaNight;
    data['wea_night_img'] = this.weaNightImg;
    data['tem'] = this.tem;
    data['tem1'] = this.tem1;
    data['tem2'] = this.tem2;
    data['humidity'] = this.humidity;
    data['visibility'] = this.visibility;
    data['pressure'] = this.pressure;
    data['win'] = this.win;
    data['win_speed'] = this.winSpeed;
    data['win_meter'] = this.winMeter;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['air'] = this.air;
    data['air_level'] = this.airLevel;
    data['air_tips'] = this.airTips;
    if (this.alarm != null) {
      data['alarm'] = this.alarm.toJson();
    }
    if (this.hours != null) {
      data['hours'] = this.hours.map((v) => v.toJson()).toList();
    }
    if (this.index != null) {
      data['index'] = this.index.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Alarm {
  String alarmType;
  String alarmLevel;
  String alarmContent;

  Alarm({this.alarmType, this.alarmLevel, this.alarmContent});

  Alarm.fromJson(Map<String, dynamic> json) {
    alarmType = json['alarm_type'];
    alarmLevel = json['alarm_level'];
    alarmContent = json['alarm_content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alarm_type'] = this.alarmType;
    data['alarm_level'] = this.alarmLevel;
    data['alarm_content'] = this.alarmContent;
    return data;
  }
}

class Hours {
  String hours;
  String wea;
  String weaImg;
  String tem;
  String win;
  String winSpeed;

  Hours({this.hours, this.wea, this.weaImg, this.tem, this.win, this.winSpeed});

  Hours.fromJson(Map<String, dynamic> json) {
    hours = json['hours'];
    wea = json['wea'];
    weaImg = json['wea_img'];
    tem = json['tem'];
    win = json['win'];
    winSpeed = json['win_speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hours'] = this.hours;
    data['wea'] = this.wea;
    data['wea_img'] = this.weaImg;
    data['tem'] = this.tem;
    data['win'] = this.win;
    data['win_speed'] = this.winSpeed;
    return data;
  }
}

class Index {
  String title;
  String level;
  String desc;

  Index({this.title, this.level, this.desc});

  Index.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    level = json['level'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['level'] = this.level;
    data['desc'] = this.desc;
    return data;
  }
}

class Aqi {
  String updateTime;
  String cityid;
  String city;
  String cityEn;
  String country;
  String countryEn;
  String air;
  String airLevel;
  String airTips;
  String pm25;
  String pm25Desc;
  String pm10;
  String pm10Desc;
  String o3;
  String o3Desc;
  String no2;
  String no2Desc;
  String so2;
  String so2Desc;
  String co;
  String coDesc;
  String kouzhao;
  String yundong;
  String waichu;
  String kaichuang;
  String jinghuaqi;

  Aqi(
      {this.updateTime,
        this.cityid,
        this.city,
        this.cityEn,
        this.country,
        this.countryEn,
        this.air,
        this.airLevel,
        this.airTips,
        this.pm25,
        this.pm25Desc,
        this.pm10,
        this.pm10Desc,
        this.o3,
        this.o3Desc,
        this.no2,
        this.no2Desc,
        this.so2,
        this.so2Desc,
        this.co,
        this.coDesc,
        this.kouzhao,
        this.yundong,
        this.waichu,
        this.kaichuang,
        this.jinghuaqi});

  Aqi.fromJson(Map<String, dynamic> json) {
    updateTime = json['update_time'];
    cityid = json['cityid'];
    city = json['city'];
    cityEn = json['cityEn'];
    country = json['country'];
    countryEn = json['countryEn'];
    air = json['air'];
    airLevel = json['air_level'];
    airTips = json['air_tips'];
    pm25 = json['pm25'];
    pm25Desc = json['pm25_desc'];
    pm10 = json['pm10'];
    pm10Desc = json['pm10_desc'];
    o3 = json['o3'];
    o3Desc = json['o3_desc'];
    no2 = json['no2'];
    no2Desc = json['no2_desc'];
    so2 = json['so2'];
    so2Desc = json['so2_desc'];
    co = json['co'];
    coDesc = json['co_desc'];
    kouzhao = json['kouzhao'];
    yundong = json['yundong'];
    waichu = json['waichu'];
    kaichuang = json['kaichuang'];
    jinghuaqi = json['jinghuaqi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['update_time'] = this.updateTime;
    data['cityid'] = this.cityid;
    data['city'] = this.city;
    data['cityEn'] = this.cityEn;
    data['country'] = this.country;
    data['countryEn'] = this.countryEn;
    data['air'] = this.air;
    data['air_level'] = this.airLevel;
    data['air_tips'] = this.airTips;
    data['pm25'] = this.pm25;
    data['pm25_desc'] = this.pm25Desc;
    data['pm10'] = this.pm10;
    data['pm10_desc'] = this.pm10Desc;
    data['o3'] = this.o3;
    data['o3_desc'] = this.o3Desc;
    data['no2'] = this.no2;
    data['no2_desc'] = this.no2Desc;
    data['so2'] = this.so2;
    data['so2_desc'] = this.so2Desc;
    data['co'] = this.co;
    data['co_desc'] = this.coDesc;
    data['kouzhao'] = this.kouzhao;
    data['yundong'] = this.yundong;
    data['waichu'] = this.waichu;
    data['kaichuang'] = this.kaichuang;
    data['jinghuaqi'] = this.jinghuaqi;
    return data;
  }
}
