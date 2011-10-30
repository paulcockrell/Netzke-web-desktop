#!/bin/bash

ls | while read -r FILE
do
  mv -v "$FILE" `echo $FILE | tr '-' '_' `
done
