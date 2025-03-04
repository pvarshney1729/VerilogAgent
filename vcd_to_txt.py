#!/usr/bin/env python3
"""
VCD to TXT Converter
This script converts Value Change Dump (.vcd) files to plain text (.txt) files.
It preserves the essential information from the VCD file in a more readable format.
"""

import sys
import re
import argparse
from datetime import datetime

def parse_vcd_file(vcd_path):
    """Parse a VCD file and extract relevant information."""
    try:
        with open(vcd_path, 'r') as f:
            vcd_content = f.read()
    except Exception as e:
        print(f"Error reading VCD file: {e}")
        sys.exit(1)
    
    # Dictionary to store signal identifiers and their names
    signal_map = {}
    
    # Extract header information
    date_match = re.search(r'\$date\s+(.*?)\s+\$end', vcd_content, re.DOTALL)
    date = date_match.group(1) if date_match else "Unknown"
    
    version_match = re.search(r'\$version\s+(.*?)\s+\$end', vcd_content, re.DOTALL)
    version = version_match.group(1) if version_match else "Unknown"
    
    timescale_match = re.search(r'\$timescale\s+(.*?)\s+\$end', vcd_content, re.DOTALL)
    timescale = timescale_match.group(1) if timescale_match else "Unknown"
    
    # Extract scope and var definitions
    scope_sections = re.findall(r'\$scope.*?\$end(.*?)(?=\$(?:upscope|enddefinitions))', vcd_content, re.DOTALL)
    
    for section in scope_sections:
        var_defs = re.findall(r'\$var\s+(\w+)\s+(\d+)\s+(\S+)\s+(\S+)(?:\s+)?(?:\[\d+:\d+\])?\s+\$end', section)
        for var_def in var_defs:
            var_type, var_size, var_id, var_name = var_def
            signal_map[var_id] = {
                'name': var_name,
                'type': var_type,
                'size': var_size
            }
    
    # Extract value changes
    value_changes = []
    
    # Time sections in the VCD file (after $enddefinitions)
    time_sections = re.findall(r'#(\d+)(.*?)(?=#\d+|$)', vcd_content.split('$enddefinitions')[1], re.DOTALL)
    
    for time, changes in time_sections:
        change_list = []
        # Match binary or scalar changes
        scalar_changes = re.findall(r'([01xXzZ])(\S+)', changes)
        for value, var_id in scalar_changes:
            if var_id in signal_map:
                change_list.append((var_id, value))
        
        # Match vector changes
        vector_changes = re.findall(r'b([01xXzZ]+)\s+(\S+)', changes)
        for value, var_id in vector_changes:
            if var_id in signal_map:
                change_list.append((var_id, f"b{value}"))
        
        if change_list:
            value_changes.append((int(time), change_list))
    
    return {
        'date': date,
        'version': version,
        'timescale': timescale,
        'signal_map': signal_map,
        'value_changes': value_changes
    }

def write_txt_str(vcd_data):
    """Write the parsed VCD data to a text file."""

    try:

        txt_str = ""

        txt_str += f"VCD File Dump\n"
        txt_str += f"============\n\n"
        txt_str += f"Date: {vcd_data['date']}\n"
        txt_str += f"Version: {vcd_data['version']}\n"
        txt_str += f"Timescale: {vcd_data['timescale']}\n\n"

        # Write signal definitions

        txt_str += f"Signal Definitions\n"
        txt_str += f"=================\n\n"
        for var_id, signal_info in vcd_data['signal_map'].items():
            txt_str += f"ID: {var_id}, Name: {signal_info['name']}, Type: {signal_info['type']}, Size: {signal_info['size']}\n"

        txt_str += f"\nValue Changes\n"
        txt_str += f"============\n\n"

        # Write value changes
        current_values = {}

        for time, changes in vcd_data['value_changes']:
            txt_str += f"Time: {time}\n"

            for var_id, value in changes:
                signal_name = vcd_data['signal_map'][var_id]['name']
                current_values[var_id] = value
                txt_str += f"  {signal_name} ({var_id}) = {value}\n"

            txt_str += "\n"
        
        # Write final state
        txt_str += f"Final Signal Values\n"
        txt_str += f"=================\n\n"
        for var_id, value in current_values.items():
            signal_name = vcd_data['signal_map'][var_id]['name']
            txt_str += f"{signal_name} ({var_id}) = {value}\n"

        return txt_str
    except Exception as e:
        return f"Error writing text file: {e}"

def convert_vcd_to_txt(vcd_path):
    """Convert a VCD file to a text and returns a 
        string with the vcd data"""

    vcd_data = parse_vcd_file(vcd_path)
    txt_str = write_txt_str(vcd_data)

    return txt_str
