#!/bin/bash
journalctl --since="$1" --until="$2"