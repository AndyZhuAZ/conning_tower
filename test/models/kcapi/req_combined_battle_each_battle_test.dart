import 'dart:convert';

import 'package:conning_tower/models/data/kcsapi/kcsapi.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test(ReqCombinedBattleEachBattleEntity.source, () {
    var json = jsonDecode('''
{"api_result":1,"api_result_msg":"成功","api_data":{"api_deck_id":1,"api_formation":[14,13,2],"api_f_nowhps":[93,81,68,74,35,43],"api_f_maxhps":[93,91,84,87,35,46],"api_f_nowhps_combined":[40,57,31,31,39,33],"api_f_maxhps_combined":[43,62,31,31,39,33],"api_fParam":[[107,0,96,104],[109,0,104,108],[23,0,73,73],[65,0,90,84],[54,72,91,52],[61,91,69,69]],"api_fParam_combined":[[63,139,49,63],[81,88,88,74],[69,87,54,50],[52,90,59,50],[67,91,87,57],[66,89,58,54]],"api_ship_ke":[1908,1779,1543,1595,1592,1622],"api_ship_lv":[1,1,1,1,1,1],"api_ship_ke_combined":[1555,1622,1622,1576,1576,1576],"api_ship_lv_combined":[1,1,1,1,1,1],"api_e_nowhps":[600,118,90,88,66,43],"api_e_maxhps":[600,118,90,88,66,43],"api_e_nowhps_combined":[57,43,43,37,37,37],"api_e_maxhps_combined":[57,43,43,37,37,37],"api_eSlot":[[1581,1582,1583,1583,-1],[1556,1557,1558,1558,-1],[1509,1509,1525,1529,-1],[1505,1505,1515,1525,-1],[1550,1550,1545,1525,-1],[1502,1502,1559,-1,-1]],"api_eSlot_combined":[[1506,1525,1542,1543,-1],[1502,1502,1559,-1,-1],[1502,1502,1559,-1,-1],[1502,1545,1542,-1,-1],[1502,1545,1542,-1,-1],[1502,1545,1542,-1,-1]],"api_eParam":[[228,0,200,270],[48,0,68,93],[85,0,70,96],[79,74,79,89],[64,92,96,68],[58,88,44,36]],"api_eParam_combined":[[48,80,30,39],[58,88,44,36],[58,88,44,36],[38,66,32,26],[38,66,32,26],[38,66,32,26]],"api_flavor_info":[{"api_boss_ship_id":"1908","api_type":"1","api_voice_id":"29405861","api_class_name":"正規空母","api_ship_name":"空母棲姫改","api_message":"ヒノ…カタマリトナッテ…シズンデシマエ……！","api_pos_x":"136","api_pos_y":"-27","api_data":""}],"api_smoke_type":0,"api_balloon_cell":0,"api_atoll_cell":0,"api_midnight_flag":0,"api_search":[1,1],"api_injection_kouku":{"api_plane_from":[[4],null],"api_stage1":{"api_f_count":6,"api_f_lostcount":0,"api_e_count":0,"api_e_lostcount":0},"api_stage2":{"api_f_count":6,"api_f_lostcount":0,"api_e_count":0,"api_e_lostcount":0},"api_stage3":{"api_frai_flag":[0,0,0,0,0,0],"api_erai_flag":[0,0,0,0,0,0],"api_fbak_flag":[0,0,0,0,0,0],"api_ebak_flag":[0,0,0,0,0,1],"api_fcl_flag":[0,0,0,0,0,0],"api_ecl_flag":[0,0,0,0,0,0],"api_fdam":[0,0,0,0,0,0],"api_edam":[0,0,0,0,0,2],"api_f_sp_list":[null,null,null,null,null,null],"api_e_sp_list":[null,null,null,null,null,null]},"api_stage3_combined":{"api_frai_flag":[0,0,0,0,0,0],"api_erai_flag":[0,0,0,0,0,0],"api_fbak_flag":[0,0,0,0,0,0],"api_ebak_flag":[0,0,0,0,0,0],"api_fcl_flag":[0,0,0,0,0,0],"api_ecl_flag":[0,0,0,0,0,0],"api_fdam":[0,0,0,0,0,0],"api_edam":[0,0,0,0,0,0],"api_f_sp_list":[null,null,null,null,null,null],"api_e_sp_list":[null,null,null,null,null,null]}},"api_air_base_attack":[{"api_base_id":1,"api_stage_flag":[1,1,1],"api_plane_from":[null,[1,2,3,4,5,7]],"api_squadron_plane":[{"api_mst_id":138,"api_count":4},{"api_mst_id":225,"api_count":18},{"api_mst_id":187,"api_count":18},{"api_mst_id":459,"api_count":18}],"api_stage1":{"api_f_count":58,"api_f_lostcount":12,"api_e_count":307,"api_e_lostcount":60,"api_disp_seiku":3,"api_touch_plane":[-1,1583]},"api_stage2":{"api_f_count":29,"api_f_lostcount":6,"api_e_count":0,"api_e_lostcount":0},"api_stage3":{"api_erai_flag":[0,0,0,0,1,0],"api_ebak_flag":[0,1,0,0,0,0],"api_ecl_flag":[0,0,0,0,0,0],"api_edam":[0,18,0,0,0,0],"api_e_sp_list":[null,[1],null,null,null,null]},"api_stage3_combined":{"api_erai_flag":[0,0,0,0,0,0],"api_ebak_flag":[0,0,0,0,0,0],"api_ecl_flag":[0,0,0,0,0,0],"api_edam":[0,0,0,0,0,0],"api_e_sp_list":[null,null,null,null,null,null]}},{"api_base_id":1,"api_stage_flag":[1,1,1],"api_plane_from":[null,[1,2,3,4,5,7]],"api_squadron_plane":[{"api_mst_id":138,"api_count":4},{"api_mst_id":225,"api_count":18},{"api_mst_id":187,"api_count":18},{"api_mst_id":459,"api_count":18}],"api_stage1":{"api_f_count":58,"api_f_lostcount":14,"api_e_count":247,"api_e_lostcount":45,"api_disp_seiku":3,"api_touch_plane":[-1,1583]},"api_stage2":{"api_f_count":27,"api_f_lostcount":6,"api_e_count":0,"api_e_lostcount":0},"api_stage3":{"api_erai_flag":[0,0,0,0,0,0],"api_ebak_flag":[0,0,0,0,0,0],"api_ecl_flag":[0,0,0,0,0,0],"api_edam":[0,0,0,0,0,0],"api_e_sp_list":[null,null,null,null,null,null]},"api_stage3_combined":{"api_erai_flag":[1,0,0,0,0,0],"api_ebak_flag":[0,0,1,0,0,0],"api_ecl_flag":[0,0,0,0,0,0],"api_edam":[82,0,164,0,0,0],"api_e_sp_list":[null,null,[1],null,null,null]}},{"api_base_id":2,"api_stage_flag":[1,1,1],"api_plane_from":[null,[1,2,3,4,5]],"api_squadron_plane":[{"api_mst_id":138,"api_count":1},{"api_mst_id":222,"api_count":17},{"api_mst_id":459,"api_count":18},{"api_mst_id":459,"api_count":18}],"api_stage1":{"api_f_count":54,"api_f_lostcount":13,"api_e_count":200,"api_e_lostcount":35,"api_disp_seiku":3,"api_touch_plane":[-1,-1]},"api_stage2":{"api_f_count":26,"api_f_lostcount":2,"api_e_count":0,"api_e_lostcount":0},"api_stage3":{"api_erai_flag":[0,0,0,0,0,0],"api_ebak_flag":[0,0,0,0,0,0],"api_ecl_flag":[0,0,0,0,0,0],"api_edam":[0,0,0,0,0,0],"api_e_sp_list":[null,null,null,null,null,null]},"api_stage3_combined":{"api_erai_flag":[0,0,0,0,0,0],"api_ebak_flag":[0,0,0,0,1,1],"api_ecl_flag":[0,0,0,0,0,0],"api_edam":[0,0,0,0,0,168],"api_e_sp_list":[null,null,null,null,[1],[1]]}},{"api_base_id":2,"api_stage_flag":[1,1,1],"api_plane_from":[null,[1,2,3,4,5]],"api_squadron_plane":[{"api_mst_id":138,"api_count":1},{"api_mst_id":222,"api_count":17},{"api_mst_id":459,"api_count":18},{"api_mst_id":459,"api_count":18}],"api_stage1":{"api_f_count":54,"api_f_lostcount":12,"api_e_count":165,"api_e_lostcount":27,"api_disp_seiku":3,"api_touch_plane":[-1,1525]},"api_stage2":{"api_f_count":29,"api_f_lostcount":9,"api_e_count":0,"api_e_lostcount":0},"api_stage3":{"api_erai_flag":[0,0,0,0,0,0],"api_ebak_flag":[0,0,0,0,1,0],"api_ecl_flag":[0,0,0,0,0,0],"api_edam":[0,0,0,0,207,0],"api_e_sp_list":[null,null,null,null,[1],null]},"api_stage3_combined":{"api_erai_flag":[0,0,0,0,0,0],"api_ebak_flag":[0,0,0,0,0,0],"api_ecl_flag":[0,0,0,0,0,0],"api_edam":[0,0,0,0,0,0],"api_e_sp_list":[null,null,null,null,null,null]}}],"api_stage_flag":[1,1,1],"api_kouku":{"api_plane_from":[[3,4,6,8],[1,2]],"api_stage1":{"api_f_count":135,"api_f_lostcount":14,"api_e_count":129,"api_e_lostcount":51,"api_disp_seiku":2,"api_touch_plane":[-1,-1]},"api_stage2":{"api_f_count":96,"api_f_lostcount":4,"api_e_count":56,"api_e_lostcount":53,"api_air_fire":{"api_idx":4,"api_kind":34,"api_use_items":[308,308]}},"api_stage3":{"api_frai_flag":[0,0,1,0,0,0],"api_erai_flag":[0,0,0,1,0,1],"api_fbak_flag":[0,0,0,0,0,0],"api_ebak_flag":[0,1,1,0,0,0],"api_fcl_flag":[0,0,0,0,0,0],"api_ecl_flag":[0,0,0,1,0,0],"api_fdam":[0,0,0,0,0,0],"api_edam":[0,10,8,171,0,15],"api_f_sp_list":[null,null,null,null,null,null],"api_e_sp_list":[null,null,null,null,null,null]},"api_stage3_combined":{"api_frai_flag":[0,0,0,0,0,0],"api_erai_flag":[0,0,0,0,0,0],"api_fbak_flag":[0,0,0,0,0,0],"api_ebak_flag":[0,0,0,1,0,0],"api_fcl_flag":[0,0,0,0,0,0],"api_ecl_flag":[0,0,0,0,0,0],"api_fdam":[0,0,0,0,0,0],"api_edam":[0,0,0,0,0,0],"api_f_sp_list":[null,null,null,null,null,null],"api_e_sp_list":[null,null,null,null,null,null]}},"api_support_flag":0,"api_support_info":null,"api_opening_taisen_flag":0,"api_opening_taisen":null,"api_opening_flag":1,"api_opening_atack":{"api_frai_list_items":[null,null,null,null,null,null,[9],[5],null,null,null,null],"api_fcl_list_items":[null,null,null,null,null,null,[2],[1],null,null,null,null],"api_fdam":[0,0,0,0,0,0,0,0,0,0,0,0],"api_fydam_list_items":[null,null,null,null,null,null,[199],[89],null,null,null,null],"api_erai_list_items":[null,null,null,null,null,null,null,null,null,null,null,null],"api_ecl_list_items":[null,null,null,null,null,null,null,null,null,null,null,null],"api_edam":[0,0,0,0,0,89,0,0,0,199,0,0],"api_eydam_list_items":[null,null,null,null,null,null,null,null,null,null,null,null]},"api_hourai_flag":[1,1,1,1],"api_hougeki1":{"api_at_eflag":[0,1,0,0,0,0,0],"api_at_list":[0,0,1,3,4,2,5],"api_at_type":[2,0,2,0,0,7,0],"api_df_list":[[1,1],[2],[2,2],[0],[0],[0],[0]],"api_si_list":[["276","390"],[-1],["9","390"],[-1],[308],["157","100","343"],[-1]],"api_cl_list":[[1,1],[0],[1,1],[1],[1],[1],[1]],"api_damage":[[161,155],[0],[151.1,163.1],[50],[63],[62],[37]]},"api_hougeki2":{"api_at_eflag":[0,0],"api_at_list":[7,11],"api_at_type":[0,0],"api_df_list":[[10],[7]],"api_si_list":[[407],[-1]],"api_cl_list":[[2],[2]],"api_damage":[[126],[70]]},"api_raigeki":{"api_frai":[-1,-1,-1,-1,-1,-1,0,0,0,0,0,0],"api_fcl":[0,0,0,0,0,0,1,1,1,1,1,2],"api_fdam":[0,0,0,0,0,0,0,0,0,0,0,0],"api_fydam":[0,0,0,0,0,0,27,41,24,35,20,22],"api_erai":[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],"api_ecl":[0,0,0,0,0,0,0,0,0,0,0,0],"api_edam":[169,0,0,0,0,0,0,0,0,0,0,0],"api_eydam":[0,0,0,0,0,0,0,0,0,0,0,0]},"api_hougeki3":{"api_at_eflag":[0,0,0,0],"api_at_list":[0,1,2,3],"api_at_type":[2,2,7,7],"api_df_list":[[0,0],[0,0],[0],[0]],"api_si_list":[["276","390"],["9","390"],["100","343"],["56","475","343"]],"api_cl_list":[[1,1],[1,1],[2],[2]],"api_damage":[[29,17],[14,21],[74],[287]]}}}    ''');

    var data = ReqCombinedBattleEachBattleEntity.fromJson(json);

    expect(data, isNotNull);

  });
}