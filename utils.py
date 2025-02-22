

import copy
import requests
import time
import os
from loguru import logger
import openai
import anthropic
from groq import Groq
import google.generativeai as google_genai
import json
import random
from litellm import completion
from openai import OpenAI
from transformers import AutoModelForCausalLM, AutoTokenizer
import torch


def generate_together(model, messages, max_tokens=2048, temperature=0.7, **kwargs):
    output = None
    request_id = random.randint(1000, 9999)  # Generate unique request ID for tracking

    key = os.environ.get("TOGETHER_API_KEY")

    logger.info(f"[Together-{request_id}] Starting request for model: {model}")
    
    for attempt, sleep_time in enumerate([1, 2, 4, 8, 16, 32], 1):
        res = None
        try:
            
            endpoint = "https://api.together.xyz/v1/chat/completions"
            time.sleep(2)

            #logger.info(f"[Together-{request_id}] Attempt {attempt}: Sending request...")
            res = requests.post(
                endpoint,
                json={
                    "model": model,
                    "max_tokens": max_tokens,
                    "temperature": (temperature if temperature > 1e-4 else 0),
                    "messages": messages,
                },
                headers={
                    "Authorization": f"Bearer {key}",
                },
            )

            output = res.json()["choices"][0]["message"]["content"]
            #logger.info(f"[Together-{request_id}] Successfully received response")
            break

        except Exception as e:
            response = "failed before response" if res is None else res
            logger.error(f"[Together-{request_id}] {e} on response: {response}")
            #logger.info(f"[Together-{request_id}] Retrying in {sleep_time}s...")
            time.sleep(sleep_time)

    if output is None:
        logger.error(f"[Together-{request_id}] Failed to get response after all attempts")
        return output

    return output.strip()


def generate_openai(model, messages, max_tokens=2048, temperature=0.7, **kwargs):

    key = os.environ.get("OPENAI_API_KEY")

    client = openai.OpenAI(api_key=key)

    if model in ["o1-preview-2024-09-12", "o1-mini-2024-09-12"]:
        messages = [msg for msg in messages if msg["role"] != "system"]

    for sleep_time in [1, 2, 4, 8, 16, 32, 64]:
        try:

            if model in ["o1-preview-2024-09-12", "o1-mini-2024-09-12"]:
                completion = client.chat.completions.create(
                    model=model,
                    messages=messages,
                )
            else:
                completion = client.chat.completions.create(
                    model=model,
                    messages=messages,
                    temperature=temperature,
                    max_tokens=max_tokens,
                )
            output = completion.choices[0].message.content
            break

        except Exception as e:
            logger.error(e)
            logger.info(f"Retry in {sleep_time}s..")
            time.sleep(sleep_time)

    output = output.strip()

    return output


def generate_anthropic(model, messages, max_tokens=2048, temperature=0.7, **kwargs):
    key = os.environ.get("ANTHROPIC_API_KEY")
    client = anthropic.Client(api_key=key)
    
    # Extract system message once outside the retry loop
    system = next((msg["content"] for msg in messages if msg["role"] == "system"), "")
    messages_alt = [msg for msg in messages if msg["role"] != "system"]
    
    for sleep_time in [1, 2, 4, 8, 16, 32, 64]:
        try:
            completion = client.messages.create(
                model=model,
                system=system,
                messages=messages_alt,
                temperature=temperature,
                max_tokens=max_tokens,
            )
            # If we get here, we have a successful response
            return completion.content[0].text.strip()
            
        except Exception as e:
            logger.error(e)
            logger.info(f"Retry in {sleep_time}s..")
            time.sleep(sleep_time)

    # If we've exhausted all retries
    return None