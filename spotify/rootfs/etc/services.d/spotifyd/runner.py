import subprocess
import sys
import re
from typing import Dict, Any

EVENT_PREFIX = 'spotify_connect_'
MSG_EVENT_NAME = 'message'
LINE_REGEX = r'\[(?P<date_time>[0-9-]{10}T[0-9:]{8}Z) (?P<severity>[A-Z]+). (?P<sender>[ -~]+)] (?P<message>[ -~]+)'
MSG_REGEXES = {
    'loading_song_regex': r'Loading <(?P<song_name>[ -~]+)> with Spotify URI <spotify:track:(?P<track_id>[A-z0-9]+)>',
    'loaded_song_regex': r'<(?P<song_name>[ -~]+)> \((?P<song_duration>[0-9]+) ms\) loaded'
}


def trigger_event(event_name: str, parameters: Dict[str, Any]):
    print(f"EVENT: {event_name}, PARAM: {parameters}")
    # TODO: Trigger HA Event
    pass


def main():
    with subprocess.Popen(['librespot', *sys.argv[1:]],
                          stdout=subprocess.PIPE,
                          stderr=subprocess.STDOUT) as p:
        for line in p.stdout:
            line = line.decode()
            try:
                parsed_line = re.match(LINE_REGEX, line)
                event_params = parsed_line.groupdict()
                msg = event_params.get('message')

                trigger_event(MSG_EVENT_NAME, event_params)

                for event, regex in MSG_REGEXES.items():
                    if re.match(regex, msg):
                        trigger_event(event, event_params)
                        continue

            except Exception as e:
                sys.stdout.write(f"W: Failed to parse line: {e}")

            sys.stdout.write(line)


if __name__ == '__main__':
    main()
