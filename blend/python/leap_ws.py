import os
import sys
import time
import json

sys.path.append(os.path.join(os.path.dirname(__file__), 'lib'))
from ws4py.client.threadedclient import WebSocketClient

class LeapClient(WebSocketClient):
    def opened(self):
        print('WS Opened')
        self.send(json.dumps({'background': True}))

    def closed(self, code, reason=None):
        print("WS Closed down", code, reason)

    def received_message(self, message):
        tmp_file = '../leapdata.json.tmp'
        leap_file = '../leapdata.json'

        msg = json.loads(str(message))
        if not 'id' in msg.keys():
            print('WS ' + str(time.clock()) + str(message))

        f = open(tmp_file, 'w')
        f.write(str(message))
        f.flush()
        #os.fsync(f.fileno()) # can be disabled to improve performances but loses atomicity
        f.close()

        os.rename(tmp_file, leap_file)

if __name__ == '__main__':
    try:
        ws = LeapClient('ws://127.0.0.1:6437/v6.json')
        ws.connect()
        ws.run_forever()
    except KeyboardInterrupt:
        ws.close()
