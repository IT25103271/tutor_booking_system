package com.tutorbooking.tutor_booking_system.repository;

import org.springframework.stereotype.Repository;
import java.io.*;
import java.nio.file.*;
import java.util.*;

@Repository
public class FileHandler {
    private static final String DATA_DIR = "data/";

    public FileHandler() {
        try {
            Files.createDirectories(Paths.get(DATA_DIR));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<String> readLines(String fileName) {
        Path path = Paths.get(DATA_DIR + fileName);
        if (!Files.exists(path)) {
            return new ArrayList<>();
        }
        try {
            return Files.readAllLines(path);
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public void writeLines(String fileName, List<String> lines) {
        try {
            Files.write(Paths.get(DATA_DIR + fileName), lines);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void appendLine(String fileName, String line) {
        try {
            Files.write(Paths.get(DATA_DIR + fileName), (line + System.lineSeparator()).getBytes(), 
                        StandardOpenOption.CREATE, StandardOpenOption.APPEND);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
