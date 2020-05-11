class NcdcModel {
  String date;
  List<StateData> stateData;
  NationalInfo nationalInfo;
  List<Hotline> hotline;
  List<Stats> stats;

  int iBy;

  NcdcModel(
      {this.date, this.hotline, this.stateData, this.nationalInfo, this.iBy});

  NcdcModel.fromJson(Map<String, dynamic> jsonMap) {
    date = jsonMap['Date'];
    
    stateData = jsonMap['States'] != null
        ? List.from(jsonMap['States'])
            .map((element) => StateData.fromJson(element))
            .toList()
        : [];
    nationalInfo = jsonMap['NCDC_National_Info'] != null
        ? NationalInfo.fromJson(jsonMap['NCDC_National_Info'])
        : {};
        hotline = jsonMap['Hotline'] != null
        ? List.from(jsonMap['Hotline'])
            .map((element) => Hotline.fromJson(element))
            .toList()
        : [];
    stats = jsonMap['item'] != null
        ? List.from(jsonMap['item'])
            .map((element) => Stats.fromJson(element))
            .toList()
        : [];

    iBy = jsonMap['i_by'];
  }
}

class StateData {
  String activeCases;
  String totalCases;
  String totalDeaths;
  String totalDischarged;
  String stateName;

  StateData(
      {this.activeCases,
      this.totalCases,
      this.totalDeaths,
      this.totalDischarged,
      this.stateName});

  StateData.fromJson(Map<String, dynamic> jsonMap) {
    activeCases = jsonMap['no_of_active_cases'];
    totalCases = jsonMap['no_of_cases'];
    totalDeaths = jsonMap['no_of_deaths'];
    totalDischarged = jsonMap['no_of_discharged'];
    stateName = jsonMap['state_name'];
  }
}

class NationalInfo {
  String deaths;
  String discharged;
  String confirmedCases;
  String totalSamplesTested;
  String activeCases;

  NationalInfo(
      {this.deaths,
      this.discharged,
      this.confirmedCases,
      this.totalSamplesTested});
  NationalInfo.fromJson(Map<String, dynamic> jsonMap) {
    deaths = jsonMap['Death'];
    discharged = jsonMap['Discharged Cases'];
    confirmedCases = jsonMap['Confirmed Cases'];
    activeCases = jsonMap['Active Cases'];
    totalSamplesTested = jsonMap['Samples Tested'];
  }
}

class Stats {
  String death;
  String discharged;
  String confirmedCases;
  String totalSamplesTested;
  String activeCases;
  String date;

  Stats(
      {this.death,
      this.discharged,
      this.confirmedCases,
      this.totalSamplesTested,
      this.date});

  Stats.fromJson(Map<String, dynamic> jsonMap) {
    death = jsonMap['Death'];
    discharged = jsonMap['Discharged Cases'];
    confirmedCases = jsonMap['Confirmed Cases'];
    activeCases = jsonMap['Active Cases'];
    totalSamplesTested = jsonMap['Samples Tested'];
    date = jsonMap['date'];
  }
}

class Hotline {
  String state;
  List<dynamic> numbers;
  Hotline({this.state, this.numbers});
  Hotline.fromJson(Map<String, dynamic> jsonMap) {
    state = jsonMap['state'];
    numbers = jsonMap['numbers'].toList();
  }
}
