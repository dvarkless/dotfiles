local llm = require "llm"

local segment = require "llm.segment"

local util = require "llm.util"
local async = require "llm.util.async"

local prompts = require "llm.prompts"
local extract = require "llm.prompts.extract"
local consult = require "llm.prompts.consult"

local llamacpp = require "llm.providers.llamacpp"

local llama_params = {
  model = "../models/wizardcoder/llama.cpp/ggml-model-q5_1.gguf",
  ["n-gpu-layers"] = 36,
  threads = 6,
  ["repeat-penalty"] = 1.2,
  temp = 0.2,
  ["ctx-size"] = 4096,
  ["n-predict"] = -1,
}

local llama_params_russian = {
  model = "../models/wizardcoder/llama.cpp/ggml-model-q5_1.gguf",
  ["n-gpu-layers"] = 36,
  threads = 6,
  ["repeat-penalty"] = 1.2,
  temp = 0.2,
  ["ctx-size"] = 4096,
  ["n-predict"] = -1,
  ["lora-base"] = "../models/lora/saiga_13b_lora",
}

local function standard_code(input, context)
  local surrounding_text = prompts.limit_before_after(context, 30)

  local instruction =
    "Replace the token <@@> with valid code. Respond only with code, never respond with an explanation, never respond with a markdown code block containing the code. Generate only code that is meant to replace the token, do not regenerate code in the context."

  local fewshot = {
    {
      role = "user",
      content = 'The code:\n```\nfunction greet(name) { console.log("Hello " <@@>) }\n```\n\nExisting text at <@@>:\n```+ nme```\n',
    },
    {
      role = "assistant",
      content = "+ name",
    },
  }

  local content = "The code:\n```\n" .. surrounding_text.before .. "<@@>" .. surrounding_text.after .. "\n```\n"

  if #input > 0 then
    content = content .. "\n\nExisting text at <@@>:\n```" .. input .. "```\n"
  end

  if #context.args > 0 then
    content = content .. context.args
  end

  local messages = {
    {
      role = "user",
      content = content,
    },
  }

  return {
    instruction = instruction,
    fewshot = fewshot,
    messages = messages,
  }
end

local llama_options = {
  path = "/run/media/dvarkless/LinuxData/Large_Language_Models/llama.cpp/",
  main_dir = "/run/media/dvarkless/LinuxData/Large_Language_Models/llama.cpp/",
}

local llamacpp_prompt = {
  llamacpp = {
    provider = llamacpp,
    params = llama_params,
    builder = function(input)
      return {
        prompt = llamacpp.llama_2_format {
          messages = {
            input,
          },
        },
      }
    end,
    options = llama_options,
  },
}

require("llm").setup {
  default_prompt = llamacpp_prompt,
  prompts = {
    ask = {
      provider = llamacpp,
      params = llama_params,
      mode = llm.mode.BUFFER,
      options = llama_options,
      builder = function(input, context)
        local details = context.segment.details()
        local row = details.row - 1
        vim.api.nvim_buf_set_lines(details.bufnr, row, row, false, { "" })

        local args_seg = segment.create_segment_at(row, 0, "Question", details.bufnr)
        args_seg.add(context.args)

        return {
          prompt = llamacpp.llama_2_format {
            messages = {
              {
                role = "user",
                content = input,
              },
              {
                role = "user",
                content = context.args,
              },
            },
          },
        }
      end,
    },
    code = {
      provider = llamacpp,
      mode = llm.mode.INSERT_OR_REPLACE,
      params = llama_params,
      options = llama_options,
      builder = function(input, context)
        return llamacpp.llama_2_format(standard_code(input, context))
      end,
      transform = extract.markdown_code,
    },
    commit = {
      provider = llamacpp,
      params = llama_params,
      mode = llm.mode.INSERT,
      options = llama_options,
      builder = function()
        local git_diff = vim.fn.system { "git", "diff", "--staged" }

        if not git_diff:match "^diff" then
          vim.notify(vim.fn.system "git status", vim.log.levels.ERROR)
          return
        end

        return {
          prompt = llamacpp.llama_2_format {
            messages = {
              {
                role = "user",
                content = "Write a terse commit message according to the Conventional Commits specification. Try to stay below 80 characters total. Staged git diff: ```\n"
                  .. git_diff
                  .. "\n```",
              },
            },
          },
        }
      end,
    },

    instruct = {
      provider = llamacpp,
      params = llama_params,
      options = llama_options,
      mode = llm.mode.REPLACE,
      builder = function(input)
        local messages = {
          {
            role = "user",
            content = input,
          },
        }
        -- There's an easier way to do this I think -- vim.ui.input
        vim.ui.input({
          prompt = "Additional instruction for prompt: ",
        }, function(user_input)
          if user_input == nil then
            return
          end

          if #user_input > 0 then
            table.insert(messages, {
              role = "user",
              content = user_input,
            })
          end

          return {
            prompt = llamacpp.llama_2_format {
              messages = messages,
            },
          }
        end)
      end,
    },
--     ["to russian"] = {
--       provider = llamacpp,
--       params = llama_params_russian,
--       options = llama_options,
--       hl_group = "SpecialComment",
--       builder = function(input)
--         return llamacpp.llama_2_format {
--           messages = {
--             {
--               role = "system",
--               content = "Translate comments and docstrings to Russian, do not change any code, do not translate technology names",
--             },
--             {
--               role = "user",
--               content = input,
--             },
--           },
--         }
--       end,
--       mode = segment.mode.REPLACE,
--     },
  },
}
