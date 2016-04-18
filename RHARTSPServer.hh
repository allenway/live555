#ifndef _RHA_RTSP_SERVER_HH
#define _RHA_RTSP_SERVER_HH

#include "DynamicRTSPServer.hh"


class RHARTSPServer: public DynamicRTSPServer {
public:
  static RHARTSPServer* createNew(UsageEnvironment& env, Port ourPort,
				      UserAuthenticationDatabase* authDatabase,
				      unsigned reclamationTestSeconds = 65);

protected:
  RHARTSPServer(UsageEnvironment& env, int ourSocket, Port ourPort,
		    UserAuthenticationDatabase* authDatabase, unsigned reclamationTestSeconds);
  // called only by createNew();
  virtual ~RHARTSPServer();

protected: // redefined virtual functions
	virtual ServerMediaSession*
	 lookupServerMediaSession(char const* streamName, Boolean isFirstLookupInSession);
};

#endif

