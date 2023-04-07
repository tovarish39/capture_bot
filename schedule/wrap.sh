#!/bin/bash
source /home/g/.bashrc


RUBY=/home/g/.rbenv/shims/ruby
BUNDLE=/home/g/.rbenv/shims/bundle
CAPTURE_BOT_PLLING_FILE_PATH=/home/g/projects/capture_bot/polling.rb

CHECK_capture_bot_on_running=check_capture_bot_on_running.rb
OUTPUT_FILE_PATH=/home/g/projects/capture_bot/tmp/output_from-wrap_sh.txt

touch $OUTPUT_FILE_PATH

pids_file_path='/home/g/projects/capture_bot/tmp/pids.txt'

pid=$(head -n 1 $pids_file_path)

case "$1" in
    ${CHECK_capture_bot_on_running})
  EXEC_FILE=${CHECK_capture_bot_on_running}


    if kill -0 $pid; then
      echo "Процесс с PID $pid работает" &>> $OUTPUT_FILE_PATH
    else
      echo "Процесс с PID $pid не работает" &>> $OUTPUT_FILE_PATH
      cd /home/g/projects/capture_bot
      $BUNDLE exec $RUBY $CAPTURE_BOT_PLLING_FILE_PATH &
    fi

        ;;
    # value2)
    #     # do something if variable equals value2
    #     ;;
    # value3|value4)
    #     # do something if variable equals value3 or value4
    #     ;;
    # *)
    #     # do something if variable doesn't match any of the above cases
    #     ;;
esac

