/**
 * @Author: 串关组合列表
 * @Date: 2023-07-30
 * @Description 串关组合列表
 */

const chuanguan_map = {
  2: { "data": [{ "count": 1, "id": "2001", "name": "2串1","type":2 }] },
  3: { "data": [{ "count": 1, "id": "3001", "name": "3串1","type":3 }, { "count": 3, "id": "2001", "name": "2串1","type":2 }, { "count": 4, "id": "3004", "name": "3串4","type":3 }] },
  4: { "data": [{ "count": 1, "id": "4001", "name": "4串1","type":4 }, { "count": 6, "id": "2001", "name": "2串1","type":2 }, { "count": 4, "id": "3001", "name": "3串1","type":3 }, { "count": 11, "id": "40011", "name": "4串11","type":4 }] },
  5: { "data": [{ "count": 1, "id": "5001", "name": "5串1","type":5 }, { "count": 10, "id": "2001", "name": "2串1","type":2 }, { "count": 10, "id": "3001", "name": "3串1" ,"type":3}, { "count": 5, "id": "4001", "name": "4串1" ,"type":4}, { "count": 26, "id": "50026", "name": "5串26","type":5 }] },
  6: { "data": [{ "count": 1, "id": "6001", "name": "6串1","type":6 }, { "count": 15, "id": "2001", "name": "2串1","type":2 }, { "count": 20, "id": "3001", "name": "3串1" ,"type":3}, { "count": 15, "id": "4001", "name": "4串1" ,"type":4}, { "count": 6, "id": "5001", "name": "5串1" ,"type":5}, { "count": 57, "id": "60057", "name": "6串57" ,"type":6}] },
  7: { "data": [{ "count": 1, "id": "7001", "name": "7串1","type":7 }, { "count": 21, "id": "2001", "name": "2串1","type":2 }, { "count": 35, "id": "3001", "name": "3串1" ,"type":3}, { "count": 35, "id": "4001", "name": "4串1" ,"type":4}, { "count": 21, "id": "5001", "name": "5串1" ,"type":5}, { "count": 7, "id": "6001", "name": "6串1" ,"type":6}, { "count": 120, "id": "700120", "name": "7串120","type":7 }] },
  8: { "data": [{ "count": 1, "id": "8001", "name": "8串1","type":8 }, { "count": 28, "id": "2001", "name": "2串1","type":2 }, { "count": 56, "id": "3001", "name": "3串1" ,"type":3}, { "count": 70, "id": "4001", "name": "4串1" ,"type":4}, { "count": 56, "id": "5001", "name": "5串1" ,"type":5}, { "count": 28, "id": "6001", "name": "6串1" ,"type":6}, { "count": 8, "id": "7001", "name": "7串1" ,"type":7}, { "count": 247, "id": "800247", "name": "8串247" ,"type":8}] },
  9: { "data": [{ "count": 1, "id": "9001", "name": "9串1","type":9 }, { "count": 36, "id": "2001", "name": "2串1","type":2 }, { "count": 84, "id": "3001", "name": "3串1" ,"type":3}, { "count": 126, "id": "4001", "name": "4串1" ,"type":4}, { "count": 126, "id": "5001", "name": "5串1" ,"type":5}, { "count": 84, "id": "6001", "name": "6串1" ,"type":6}, { "count": 36, "id": "7001", "name": "7串1" ,"type":7}, { "count": 9, "id": "8001", "name": "8串1" ,"type":8}, { "count": 502, "id": "900502", "name": "9串502","type":9 }] },
  10: { "data": [{ "count": 1, "id": "10001", "name": "10串1","type":10 }, { "count": 45, "id": "2001", "name": "2串1","type":2 }, { "count": 120, "id": "3001", "name": "3串1" ,"type":3}, { "count": 210, "id": "4001", "name": "4串1","type":4 }, { "count": 252, "id": "5001", "name": "5串1" ,"type":5}, { "count": 210, "id": "6001", "name": "6串1","type":6 }, { "count": 120, "id": "7001", "name": "7串1" ,"type":7}, { "count": 45, "id": "8001", "name": "8串1" ,"type":8}, { "count": 10, "id": "9001", "name": "9串1" ,"type":9}, { "count": 1013, "id": "10001013", "name": "10串1013","type":10 }] }
};

