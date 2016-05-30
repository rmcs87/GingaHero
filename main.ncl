<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="gameNcl" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<!-- Regioes -->
		<regionBase>
			<region id="rgTv">
				<region id="rgIntro" height="100%" width="100%" zIndex="1"/>
				<region id="rgGame" height="100%" width="100%" zIndex="2"/>
			</region>
		</regionBase>
		<!-- Descritores -->
		<descriptorBase>
			<descriptor id="dIntro" region="rgIntro"/>
			<descriptor focusIndex="luaGame" id="dGame" region="rgGame"/>
			<descriptor id="dSong" region="rgTv"/>
		</descriptorBase>
		<!-- Conectores -->
		<connectorBase>
			<causalConnector id="onBeginStartStop">
				<simpleCondition role="onBegin"/>
				<compoundAction operator="seq">
					<simpleAction role="start"/>	
					<simpleAction role="stop"/>
				</compoundAction>				
			</causalConnector>
			<causalConnector id="onBeginStart">
				<simpleCondition role="onBegin"/>
				<simpleAction role="start"/>
			</causalConnector>
			<causalConnector id="onBeginStartN">
				<simpleCondition role="onBegin"/>
				<simpleAction max="unbounded" qualifier="par" role="start"/>
			</causalConnector>
			<causalConnector id="onPausePause">
				<simpleCondition role="onPause"/>
				<simpleAction role="pause"/>
			</causalConnector>
			<causalConnector id="onResumeReesume">
				<simpleCondition role="onResume"/>
				<simpleAction role="resume"/>
			</causalConnector>
			<causalConnector id="onStopStop">
				<simpleCondition role="onEnd"/>
				<simpleAction role="stop"/>
			</causalConnector>
			<causalConnector id="onBeginSet">
				<simpleCondition role="onBegin"/>
				<simpleAction role="set" value="$newSound"/>
			</causalConnector>
			<causalConnector id="onEndSet">
				<simpleCondition role="onEnd"/>
				<simpleAction role="set" value="$newSound"/>
			</causalConnector>
		</connectorBase>
	</head>
	<body>
		<!-- Porta -->
		<port component="game" id="pBody"/>
		<!-- Medias -->
		<media id="programSettings" type="application/x-ginga-settings">
			<property name="service.currentKeyMaster" value="luaGame"/>
		</media>
			<!-- Controle -->
		<media id="lua" src="frame/hero.lua" descriptor="dGame"/>
			<!-- Audio -->
		<media descriptor="dGame" id="game" src="frame/hero.lua">
			<area id="introPlay"/>			
			<area id="introStart"/>
			
			<area id="erroPlay"/>
			<area id="erroMute"/>
			<area id="erroStart"/>
			
			<area id="guitarPlay"/>
			<area id="guitarMute"/>
			<area id="guitarStart"/>
			
			<area id="songPlay"/>
			<area id="songMute"/>
			<area id="songStart"/>
			
			<area id="fundoPlay"/>
			<area id="fundoMute"/>
			<area id="fundoStart"/>
		</media>
		
		<media id="intro" src="video/intro.mp4" descriptor="dIntro"/>
		
		<media id="fundo" src="som/fundo.mp3" descriptor="dSong">
			<property name="soundLevel"/>			
		</media>
		
		<media id="erro" src="som/erro.mp3" descriptor="dSong">
			<property name="soundLevel"/>			
		</media>
		<media id="guitar" src="som/guitar.mp3" descriptor="dSong">
			<property name="soundLevel"/>			
		</media>
		<media id="song" src="som/song.mp3" descriptor="dSong">
			<property name="soundLevel"/>			
		</media>		
		
		<!-- Links Song Obs. Ao iniciar tudo junto, pode dar erro, se der, tente um descritor para cada-->
		<link id="inciaIntro" xconnector="onBeginStart">
			<bind component="game" interface="introPlay" role="onBegin"/>
			<bind component="intro" role="start"/>
		</link>
		<link id="StartIntro" xconnector="onBeginStartStop">
			<bind component="game" interface="introStart" role="onBegin"/>
			<bind component="intro" role="start"/>
			<bind component="intro" role="stop"/>
		</link>
		<link id="PausaIntro" xconnector="onPausePause">
			<bind component="game" interface="introPlay" role="onPause"/>
			<bind component="intro" role="pause"/>
		</link>
		<link id="ResumeIntro" xconnector="onResumeReesume">
			<bind component="game" interface="introPlay" role="onResume"/>
			<bind component="intro" role="resume"/>
		</link>
		<link id="StopIntro" xconnector="onStopStop">
			<bind component="game" interface="introPlay" role="onEnd"/>
			<bind component="intro" role="stop"/>
		</link>	
		
		<!-- Links Song Obs. Ao iniciar tudo junto, pode dar erro, se der, tente um descritor para cada-->
		<link id="inciaFundo" xconnector="onBeginStart">
			<bind component="game" interface="fundoPlay" role="onBegin"/>
			<bind component="fundo" role="start"/>
		</link>
		<link id="StartFundo" xconnector="onBeginStartStop">
			<bind component="game" interface="fundoStart" role="onBegin"/>
			<bind component="fundo" role="start"/>
			<bind component="fundo" role="stop"/>
		</link>
		<link id="PausaFundo" xconnector="onPausePause">
			<bind component="game" interface="fundoPlay" role="onPause"/>
			<bind component="fundo" role="pause"/>
		</link>
		<link id="ResumeFundo" xconnector="onResumeReesume">
			<bind component="game" interface="fundoPlay" role="onResume"/>
			<bind component="fundo" role="resume"/>
		</link>
		<link id="StopFundo" xconnector="onStopStop">
			<bind component="game" interface="fundoPlay" role="onEnd"/>
			<bind component="fundo" role="stop"/>
		</link>
		<link id="MuteFundo" xconnector="onBeginSet">
			<bind component="game" interface="fundoMute" role="onBegin"/>
			<bind component="fundo" role="set" interface="soundLevel">
				<bindParam name="newSound" value="0"/>				
			</bind>
		</link>
		<link id="UnMuteFundo" xconnector="onEndSet">
			<bind component="game" interface="fundoMute" role="onEnd"/>
			<bind component="fundo" role="set" interface="soundLevel">
				<bindParam name="newSound" value="1"/>				
			</bind>
		</link>
		
		<!-- Links Song Obs. Ao iniciar tudo junto, pode dar erro, se der, tente um descritor para cada-->
		<link id="inciaSong" xconnector="onBeginStart">
			<bind component="game" interface="songPlay" role="onBegin"/>
			<bind component="song" role="start"/>
		</link>
		<link id="StartSong" xconnector="onBeginStartStop">
			<bind component="game" interface="songStart" role="onBegin"/>
			<bind component="song" role="start"/>
			<bind component="song" role="stop"/>
		</link>
		<link id="PausaSong" xconnector="onPausePause">
			<bind component="game" interface="songPlay" role="onPause"/>
			<bind component="song" role="pause"/>
		</link>
		<link id="ResumeSong" xconnector="onResumeReesume">
			<bind component="game" interface="songPlay" role="onResume"/>
			<bind component="song" role="resume"/>
		</link>
		<link id="StopSong" xconnector="onStopStop">
			<bind component="game" interface="songPlay" role="onEnd"/>
			<bind component="song" role="stop"/>
		</link>
		<link id="MuteSong" xconnector="onBeginSet">
			<bind component="game" interface="songMute" role="onBegin"/>
			<bind component="song" role="set" interface="soundLevel">
				<bindParam name="newSound" value="0"/>				
			</bind>
		</link>
		<link id="UnMuteSong" xconnector="onEndSet">
			<bind component="game" interface="songMute" role="onEnd"/>
			<bind component="song" role="set" interface="soundLevel">
				<bindParam name="newSound" value="1"/>				
			</bind>
		</link>
			
		<!-- Links Guitar Obs. Ao iniciar tu junto, pode dar erro, se der, tente um descritor para cada-->
		<link id="inciaGuitar" xconnector="onBeginStart">
			<bind component="game" interface="guitarPlay" role="onBegin"/>
			<bind component="guitar" role="start"/>
		</link>
		<!--<link id="StartGuitar" xconnector="onBeginStartNStopN">-->
		<link id="StartGuitar" xconnector="onBeginStartStop">
			<bind component="game" interface="guitarStart" role="onBegin"/>
			<bind component="guitar" role="start"/>
			<bind component="guitar" role="stop"/>
		</link>
		<link id="Pausaguitar" xconnector="onPausePause">
			<bind component="game" interface="guitarPlay" role="onPause"/>
			<bind component="guitar" role="pause"/>
		</link>
		<link id="Resumeguitar" xconnector="onResumeReesume">
			<bind component="game" interface="guitarPlay" role="onResume"/>
			<bind component="guitar" role="resume"/>
		</link>
		<link id="Stopguitar" xconnector="onStopStop">
			<bind component="game" interface="guitarPlay" role="onEnd"/>
			<bind component="guitar" role="stop"/>
		</link>
		<link id="Muteguitar" xconnector="onBeginSet">
			<bind component="game" interface="guitarMute" role="onBegin"/>
			<bind component="guitar" role="set" interface="soundLevel">
				<bindParam name="newSound" value="0"/>				
			</bind>
		</link>
		<link id="UnMuteguitar" xconnector="onEndSet">
			<bind component="game" interface="guitarMute" role="onEnd"/>
			<bind component="guitar" role="set" interface="soundLevel">
				<bindParam name="newSound" value="0.8"/>				
			</bind>
		</link>
			
		<!-- Links Error Obs. Ao iniciar tu junto, pode dar erro, se der, tente um descritor para cada-->
		<link id="inciaErro" xconnector="onBeginStart">
			<bind component="game" interface="erroPlay" role="onBegin"/>
			<bind component="erro" role="start"/>
		</link>
		<link id="PausaErro" xconnector="onPausePause">
			<bind component="game" interface="erroPlay" role="onPause"/>
			<bind component="erro" role="pause"/>
		</link>
		<link id="ResumeErro" xconnector="onResumeReesume">
			<bind component="game" interface="erroPlay" role="onResume"/>
			<bind component="erro" role="resume"/>
		</link>
		<link id="StopErro" xconnector="onStopStop">
			<bind component="game" interface="erroPlay" role="onEnd"/>
			<bind component="erro" role="stop"/>
		</link>
		<link id="MuteErro" xconnector="onBeginSet">
			<bind component="game" interface="erroMute" role="onBegin"/>
			<bind component="erro" role="set" interface="soundLevel">
				<bindParam name="newSound" value="0"/>				
			</bind>
		</link>
		<link id="UnMuteErro" xconnector="onEndSet">
			<bind component="game" interface="erroMute" role="onEnd"/>
			<bind component="erro" role="set" interface="soundLevel">
				<bindParam name="newSound" value="1"/>				
			</bind>
		</link>
	</body>
</ncl>
