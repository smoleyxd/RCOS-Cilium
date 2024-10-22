import http from 'k6/http';
import { check } from 'k6';

export default function () {
  let res = http.get('http://nginx-service');
  check(res, {
    'status is 200': (r) => r.status === 200,
  });
}
