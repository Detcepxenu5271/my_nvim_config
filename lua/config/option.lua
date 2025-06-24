-- 这里的配置都是默认应用 global
-- 即使选项是 local to buf/win, 也会被默认 global 覆盖 (除非 setlocal, 或设置 bo/wo 的值)

-- 简写
-- vim.opt 同 set, 默认设置 global 和 local (buffer/window)
local opt = vim.opt

-- ======== 外 观 (ui) ========

-- 行号
opt.number = true
opt.relativenumber = true

-- 高亮当前行
opt.cursorline = true

-- 状态栏，0 不显示，1 只在多窗口时显示，2 一直显示
-- [DEFAULT] opt.laststatus = 2

-- 标签栏, 默认不显示, 配合 <leader><leader>t 切换显示/不显示
-- [DEFAULT] opt.showtabline = 1

-- 是否显示空白字符
opt.list = true
--opt.listchars = {eol = '$', tab = '>-', trail = 'X'}
opt.listchars = {tab = '>-', trail = 'X'}

-- ======== 格 式 (format) ========

opt.smartindent = true
opt.tabstop = 4
opt.shiftround = true
opt.shiftwidth = 4

-- ======== 移 动 (motion) ========

opt.jumpoptions:append('stack')

-- ======== 编 辑 (edit) ========

-- CTRL-A/CTRL-X 还会加/减单个字母
opt.nrformats:append('alpha')

-- CTRL-V 会选中明确的矩形区域, 本来没有字符的按空格处理
opt.virtualedit:append('block')

-- ======== 窗 口 (window) ========

-- 新建/分割窗口时, 不会让所有窗口等高/宽, 而是在当前窗口分割
-- 可以用 CTRL-W_= 让所有窗口等宽
opt.equalalways = false

-- 窗口
-- 新建的窗口会位于右下方
opt.splitbelow = true
opt.splitright = true

-- ======== 搜 索 (search) ========

-- 初始只使用当前文件相对路径和当前目录作为搜索路径 (不使用 /usr/include)
-- 在当前目录 (vim 的 pwd) 搜索时, 不采用向下递归搜索 (downwards search). 使用 find 命令时, 可以手动加入 **
-- [DEFAULT] opt.path = {'.', ','}
-- 搜索到结尾时不回头
opt.wrapscan = false
-- 默认忽略大小写, 可以通过在 pattern 中加入 \C 强制大小写敏感
opt.ignorecase = true
opt.smartcase = true

-- 补全
-- 不在 unloaded buffer 中搜索, 在 dictionary 和 thesaurus 中搜索
opt.complete:remove('u')
opt.complete:append('k')
opt.complete:append('s')

-- ======== 文 件 (file) ========

-- 创建备份文件, 在备份文件目录列表中取消当前目录
opt.backup = true
opt.backupdir:remove('.')

-- 交换文件和撤销文件
opt.swapfile = true
opt.undofile = true

-- 多窗口下光标移动到其他窗口时, 不要自动切换工作目录
-- [DEFAULT] opt.autochdir = false

-- 文件自动检测外部更改
-- [DEFAULT] opt.autoread = true

-- session 文件
-- 不包括 buffers 选项, 只记录当前打开的 buffer
opt.sessionoptions:remove('buffers')

-- ======== 命 令 行 (cmdline) ========

-- longest: 会匹配到最长的公共前缀
-- full: 然后匹配每一个可能的
opt.wildmode = {'longest', 'full'}
opt.wildoptions:append('fuzzy')

-- ======== 其 他 (else) ========

-- 输入括号时，会暂时跳转到匹配的括号
--opt.showmatch = true
--opt.matchtime = 5

-- 剪贴板
opt.clipboard:append('unnamedplus')

-- K 改为使用 vim 的 help 查询, 而不是 :Man
opt.keywordprg = ':help'

-- ======== 内 置 插 件 (builtin) ========

-- netrw tree

-- 禁用横幅
vim.g.netrw_banner = 0
-- 初始窗口大小为25%
--vim.g.netrw_winsize=25
-- 使用树形结构
-- 可以用 - 到上一级目录, gn 将根目录设为光标处的目录
vim.g.netrw_liststyle = 3
-- 分割窗口时默认在右边
vim.g.netrw_altv = 1
-- enter时在上一个窗口打开
-- 可以用预览操作: p 是打开新窗口, P 是在上一个窗口打开
--vim.g.netrw_browse_split=4
-- 预览窗口为垂直方向
vim.g.netrw_preview = 1
-- 该变量会覆盖 vimrc 的配置, 这里是为了让 netrw 显示行号
vim.g.netrw_bufsettings = 'noma nomod nonu nowrap ro nobl'

-- markdown

-- 暂时用内置的 folding
vim.g.markdown_folding = 1

