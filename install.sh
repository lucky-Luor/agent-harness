#!/usr/bin/env bash
# install.sh —— 把 agent-harness 母版装进任意目标项目
# 作用: 拷 templates/.agent-hub 与 templates/CLAUDE.md 进目标项目根,
#       并把这两项追加到目标项目的 .gitignore(保持个人运行态、不污染团队仓库)。
# 用法: ./install.sh <目标项目根目录>

set -euo pipefail  # 出错即停 / 用未定义变量即停 / 管道任一环失败即停

TARGET="${1:-}"    # 第一个参数 = 目标项目根目录, 缺省为空串
# 目标缺失或不是目录 → 打印用法并以非 0 退出
if [ -z "$TARGET" ] || [ ! -d "$TARGET" ]; then
  echo "用法: $0 <目标项目根目录>"       # 提示正确用法
  exit 1                                    # 参数不合法, 退出码 1
fi

# 母版 templates 目录的绝对路径(以本脚本所在位置为基准, 不依赖调用时的工作目录)
SRC="$(cd "$(dirname "$0")" && pwd)/templates"

# 1. 拷 .agent-hub/ 到目标项目; -n = 不覆盖已存在文件, 保护用户已填写的 GUIDE / 任务
cp -rn "$SRC/.agent-hub" "$TARGET/"
echo "已放置 $TARGET/.agent-hub/(已存在的文件不覆盖)"

# 2. 拷 CLAUDE.md 到目标项目根; 已存在则跳过, 避免覆盖用户已有入口
if [ ! -e "$TARGET/CLAUDE.md" ]; then
  cp "$SRC/CLAUDE.md" "$TARGET/CLAUDE.md"  # 目标无 CLAUDE.md 时才拷入
  echo "已放置 $TARGET/CLAUDE.md"
else
  echo "跳过 CLAUDE.md(目标已存在, 未覆盖)"
fi

# 3. 把 .agent-hub/ 与 CLAUDE.md 追加进目标项目的 .gitignore(逐项去重)
GI="$TARGET/.gitignore"                     # 目标项目的 .gitignore 路径
touch "$GI"                                 # 不存在则创建空文件
add_ignore() {                              # 幂等追加一行忽略规则的函数
  local rule="$1"                           # 待追加的忽略规则
  # 用固定字符串精确匹配整行, 已存在则不重复追加
  if ! grep -qxF "$rule" "$GI"; then
    echo "$rule" >> "$GI"                    # 未命中 → 追加到文件末尾
    echo "  + 已忽略 $rule"                  # 反馈本次新增的规则
  fi
}
# 若本次是首次追加, 先写一行注释说明来源, 便于日后辨认
if ! grep -qF "agent-harness 个人运行态" "$GI"; then
  echo "" >> "$GI"                                          # 先空一行与上文隔开
  echo "# agent-harness 个人运行态: 不入库(见 lucky-Luor/agent-harness)" >> "$GI"
fi
add_ignore ".agent-hub/"                     # 忽略个人任务状态工作区
add_ignore "CLAUDE.md"                        # 忽略个人 Claude 入口(内容因人而异)

echo "完成。下一步: 编辑 $TARGET/.agent-hub/GUIDE.md, 填成本项目的任务类型映射。"
