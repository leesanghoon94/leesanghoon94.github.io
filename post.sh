#!/bin/bash

echo "post"
read post
mkdir -p _posts/$post
touch date.$post.md