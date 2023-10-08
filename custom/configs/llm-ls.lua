local llm = require "llm"

local segment = require "llm.segment"

local util = require "llm.util"
local async = require "llm.util.async"

local prompts = require "llm.prompts"
local extract = require "llm.prompts.extract"
local consult = require "llm.prompts.consult"

local library = require "custom.configs.prompts"

local llamacpp = require "llm.providers.llamacpp"

local ALPACA_SYS_BEGIN = ""
local ALPACA_SYS_END = "\n\n"
local ALPACA_INST_BEGIN = "### Instruction:\n"
local ALPACA_INST_END = "\n### Response:\n"

local LLAMA_SYS_BEGIN = "<<SYS>>\n"
local LLAMA_SYS_END = "\n<</SYS>>\n\n"
local LLAMA_INST_BEGIN = "<s>[INST]"
local LLAMA_INST_END = "[/INST]"

local VICUNA_SYS_BEGIN = "SYSTEM:\n"
local VICUNA_SYS_END = "\n\n"
local VICUNA_INST_BEGIN = "USER:\n"
local VICUNA_INST_END = "\nASSISTANT:\n"

local CHATML_SYS_BEGIN = "<|im_start|>system\n"
local CHATML_SYS_END = "<|im_end|>\n"
local CHATML_INST_BEGIN = "<|im_start|>user\n"
local CHATML_INST_END = "<|im_end|>\n<|im_start|>assistant\n"




-- Current model is "Nous Hermes Code" (Alpaca template)
local llama_params = {
  temperature = 0.2, -- Adjust the randomness of the generated text (default: 0.8).
  seed = -1, -- Set the random number generator (RNG) seed (default: -1, -1 = random seed)
  n_predict = 1200,
  mirostat = 2,
  mirostat_tau = 5.0,
  mirostat_eta = 0.1,
}

local llama_params_high_temp = {
  temperature = 0.7, -- Adjust the randomness of the generated text (default: 0.8).
  seed = -1, -- Set the random number generator (RNG) seed (default: -1, -1 = random seed)
  n_predict = 1200,
  mirostat = 2,
  mirostat_tau = 5.0,
  mirostat_eta = 0.1,
}


local SYSTEM_BEGIN = ALPACA_SYS_BEGIN
local SYSTEM_END = ALPACA_SYS_END
local INST_BEGIN = ALPACA_INST_BEGIN
local INST_END = ALPACA_INST_END


local function wrap_instr(text)
  return table.concat({
    INST_BEGIN,
    text,
    INST_END,
  }, "\n")
end

local function wrap_sys(text)
  return SYSTEM_BEGIN .. text .. SYSTEM_END
end

local default_system_prompt = library.system_default

---@param prompt { system?: string, messages: string[]} -- messages are alternating user/assistant strings
local llama_2_chat = function(prompt)
  local texts = {}

  for i, message in ipairs(prompt.messages) do
    if i % 2 == 0 then
      table.insert(texts, wrap_instr(message))
    else
      table.insert(texts, message)
    end
  end

  return wrap_sys(prompt.system or default_system_prompt) .. table.concat(texts, "\n") .. "\n"
end

---@param prompt { system?: string, message: string , inst_begin: string, inst_end: string, sys_begin: string, sys_end: string}
local llama_2_system_prompt = function(prompt) -- correct but does not give as good results as llama_2_user_prompt
  return wrap_instr(wrap_sys(prompt.system or default_system_prompt) .. prompt.message)
end

---@param prompt { user: string, message: string } -- for coding problems
local llama_2_user_prompt = function(prompt) -- somehow gives better results compared to sys prompt way...
  return wrap_instr(prompt.user .. "\n'''\n" .. prompt.message .. "\n'''\n") -- wrap messages in '''
end

---@param prompt { system?:string, user: string, message?: string }
local llama_2_general_prompt = function(prompt) -- somehow gives better results compared to sys prompt way...
  local message = ""
  if prompt.message ~= nil then
    message = "\n'''\n" .. prompt.message .. "\n'''\n"
  end
  -- best way to format is iffy. better: wrap_system() .. wrap_instr(), but should be: wrap_instr(wrap_system(sys_msg) .. message) by docs
  return wrap_instr(wrap_sys(prompt.system or default_system_prompt) .. prompt.user .. message)
end

local my_prompt = {
  provider = llamacpp,
  params = llama_params,
  builder = function(input)
    return function(build)
      vim.ui.input({ prompt = "Instruction: " }, function(user_input)
        build {
          prompt = llama_2_user_prompt {
            user = user_input or "",
            message = input,
          },
        }
      end)
    end
  end,
}

local replace = {
  provider = llamacpp,
  params = llama_params,
  mode = llm.mode.REPLACE,
  builder = function(input)
    return function(build)
      vim.ui.input({ prompt = "Instruction: " }, function(user_input)
        build {
          prompt = llama_2_user_prompt {
            user = user_input or "",
            message = input,
          },
        }
      end)
    end
  end,
}

local commit = {
  provider = llamacpp,
  params = llama_params_high_temp,
  mode = llm.mode.INSERT,
  builder = function()
    local git_diff = vim.fn.system { "git", "diff", "--staged" }

    if not git_diff:match "^diff" then
      vim.notify(vim.fn.system "git status", vim.log.levels.ERROR)
      return
    end

    return function(build)
      build {
        prompt = llama_2_user_prompt {
          user = library.commit_instruction,
          message = git_diff,
        },
      }
    end
  end,
}

local unittest = {
  provider = llamacpp,
  params = llama_params_high_temp,
  mode = llm.mode.INSERT,
  builder = function(input)
    return function(build)
      build {
        prompt = llama_2_general_prompt {
          system = library.unittest_system,
          user = library.unittest_instruction,
          message = input,
        },
      }
    end
  end,
}

local to_russian = {
  provider = llamacpp,
  params = llama_params,
  hl_group = 'SpecialComment',
  mode = llm.mode.REPLACE,
  builder = function(input)
    return function(build)
      build {
        prompt = llama_2_user_prompt {
          user = library.translate_to_russian_instruction,
          message = input,
        },
      }
    end
  end,
}

require("llm").setup {
  default_prompt = my_prompt,
  prompts = {
    commit = commit,
    unittest = unittest,
    to_russian = to_russian,
    replace = replace,
  },
}

