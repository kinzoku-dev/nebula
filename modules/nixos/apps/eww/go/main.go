package main

import (
	"fmt"

	"github.com/godbus/dbus/v5"
	"github.com/gotk3/gotk3/glib"
)

func main() {
	bus, err := dbus.SessionBus()
	errHan(err)

	bus.AddMatchSignal(
		dbus.WithMatchOption("interface", "'org.freedesktop.Notifications'"),
	)

	message, err := bus.ReadMessage()
	errHan(err)

	fmt.Println(message.String())

	mainloop := glib.MainLoopNew(glib.MainContextDefault(), true)
	mainloop.Run()
}

func errHan(err error) {
	if err != nil {
		panic(err)
	}
}
