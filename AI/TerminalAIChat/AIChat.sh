#!/bin/bash

# 请求参数
ContentType="application/json";

# 颜色
TipColor="\033[31m"; # 重要信息文本颜色
InputColor="\033[34m"; # 用户输入文本颜色
AIShowColor="\033[32m"; # 普通信息文本颜色
CodeColor="\033[36m"; # 代码颜色
AIOutPutColor="\033[37m"; # AI输出文本颜色

# 缓存地址
GPTChatCacheFile=$OpenAI_OutputFile;
# gpt-4、gpt-4-0314、gpt-4-32k、gpt-4-32k0314、gpt-3.5-turbo-0301
OpenAI_Model="gpt-3.5-turbo";

gptChat() {
	isRepestInput=1; # 1重新输入，0不重新输入
	userTopicContent=""; # 接收用户输入
	apiKeyValid=1; # 1表示有效，0表示无效

	while [[ true ]]; do
		if ((isRepestInput == 1)); then
			echo -e -n "\n${AIShowColor}请输入你的问题：$InputColor ";
			read InputContent; # 接收输入值
			userTopicContent=$InputContent;

		fi

		if  ((${#userTopicContent} == 0)); then
			echo -e -n "${AIShowColor}输入不能为空，请重新输入：$InputColor ";
			read InputContent;

			userTopicContent=$InputContent;
			isRepestInput=0;

		else
			echo -e "${TipColor}AI助手将马上回复你...";

			# chatgpt缓存地址
			if  ((${#GPTChatCacheFile} == 0)); then
				GPTChatCacheFile="gptChatCache.json";

			fi

    	    # curl请求，将输出内容写入一个文件中
			curl -sS https://api.openai.com/v1/chat/completions \
			  -H "Content-Type: $ContentType" \
			  -H "Authorization: Bearer $OpenAI_API_KEY" \
			  -d "{
			     \"model\": \"$OpenAI_Model\",
			     \"messages\": [{\"role\": \"user\", \"content\": \"$userTopicContent\"}],
			     \"temperature\": 0.7
			   }"\
			   > $GPTChatCacheFile;

			# 获取文件中指定行的内容
			content=$(cat $GPTChatCacheFile |grep -o "\"content\": .*"| awk -F": " '{print $0}'|head -n 1);

			# 字符串截取
			content=${content:12};
			content=${content%\"*};

			# 反转字符串
			InvertStr="\`\`\`";

			# 支持高亮的上下文语言
			langs=('javascript' 'java' 'ruby' 'html' 'css' 'less' 'sass' 'typescript' 'go' 'shell' 'c' 'c#' 'c++' 'php' 'python' 'xml' 'swift' 'ecmascript' 'vue' 'react');
			langI=0; # 索引
			langLen=${#langs[*]}; # 数组长度

			# 代码上下文高亮显示
			codeContextColor(){
				lang=$1;
				content=${content//$InvertStr$lang/$TipColor$InvertStr$TipColor$lang$CodeColor};
			}

			# 代码语法高亮显示
			while(( $langI < $langLen )); do
				curIndexValue=${langs[langI]};
				codeContextColor $curIndexValue;
			    let "langI++";

			done

			# 最后文本内容显示的颜色
			content=${content//$InvertStr/$TipColor$InvertStr$TipColor$AIOutPutColor};

			# 因网路各种原因，则不输入
			contentLen=${#content};

			if (( contentLen > 0 )); then
				echo -e "\n${AIShowColor}AI助手：==> \n\n$AIOutPutColor$content\n";
				break;

			else
				errorInfo=$(cat $GPTChatCacheFile |grep -o "\"message\": .*"| awk -F": " '{print $0}'|head -n 1);
				# 字符串截取
				errorInfo=${errorInfo:12};
				errorInfo=${errorInfo%\"*};
				errorTips=$errorInfo;

				if (( ${#errorTips} == 0 )); then
					# 网络请求失败，未收到响应
					errorTips="数据接收失败，可能是否你的网络原因，请调试网络后重试！";
					isRepestInput=1;
					echo -e "\n${TipColor}警告⚠️：==> \n\n$errorTips\n";

				else
					# 一般是apikey无效
					apiKeyValid=0;
					echo -e "\n${TipColor}警告⚠️：==> \n\n$errorTips\n";
					break;

				fi

			fi

		fi

	done

	return $apiKeyValid;
}

clearScreen(){
	# 是否清屏
	echo -e -n "${AIShowColor}按任何键继续，输入clear清屏：$InputColor ";
	read isClear;

	case $isClear in
		"clear")
			clear;
		;;
		*)
	esac
}

loopExec(){
	while [[ true ]]; do
		echo -e -n "${AIShowColor}按任何键继续，输入yes退出：$InputColor ";
		read isExit;

		case $isExit in
    	    "yes")
				echo -e "\n${TipColor}AI助手已退出，感谢你的使用！\n";
				break;

    		;;
    		*)
				clearScreen;
    	        gptChat;

    	    ;;
    	esac
	done
}

echo -e "\n${AIShowColor}Hi！我是你的AI助手，现在时间：`date +'%Y年%m月%d日 %H:%M:%S'`";
echo -e "${AIShowColor}有什么能帮助你的，我什么都知道哦!";

gptChat;
# 若是api key失效，不再进行循环
if (($? == 1)); then
	loopExec;
else
	echo -e "\n${TipColor}你的API Key 已经失效，请更换有效API Key，才能正常使用！\n"
fi
