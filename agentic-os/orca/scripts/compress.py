#!__HOME__/.orca/env/bin/python

import sys
import argparse
from llmlingua import PromptCompressor

def main():
    parser = argparse.ArgumentParser(description="Comprime logs e textos para economizar tokens do LLM.")
    parser.add_argument("--ratio", type=float, default=0.5, help="Taxa de compressão alvo (ex: 0.5 para manter 50%% dos tokens)")
    args = parser.parse_args()

    input_text = sys.stdin.read()
    if not input_text.strip():
        sys.exit(0)

    # Inicializa o compressor (fará o download do modelo pequeno na primeira execução)
    compressor = PromptCompressor("microsoft/llmlingua-2-xlm-roberta-large-meetingbank", use_llmlingua2=True, device_map="cpu")
    
    result = compressor.compress_prompt(
        context=[input_text],
        rate=args.ratio,
        force_tokens=['\n']
    )
    
    print(result['compressed_prompt'])

if __name__ == "__main__":
    main()
